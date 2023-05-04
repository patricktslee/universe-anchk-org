import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart';
import 'dart:io';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

Future<void> start(final req, final res) async {
  Map<String, String> envVars = Platform.environment;
  var emailFunctionStatus = 'Sendgrid Email Function Status: \n';
  bool accountDeteted = false;

  Client client = Client();
  Databases database = Databases(client);
  if (envVars['APPWRITE_FUNCTION_ENDPOINT'] == null ||
      envVars['APPWRITE_FUNCTION_PROJECT_ID'] == null ||
      envVars['APPWRITE_FUNCTION_API_KEY'] == null) {
    final appwriteEnvError =
        "Appwrite function Environment variables are not set. Function cannot use Appwrite SDK. APPWRITE_FUNCTION_PROJECT_ID is ${req.env['APPWRITE_FUNCTION_PROJECT_ID']}.  ";
    emailFunctionStatus = emailFunctionStatus + appwriteEnvError;
  } else {
    try {
      client
          .setEndpoint(envVars['APPWRITE_FUNCTION_ENDPOINT']!)
          .setProject(envVars['APPWRITE_FUNCTION_PROJECT_ID'])
          .setKey(envVars['APPWRITE_FUNCTION_API_KEY']);
      database = Databases(client);
    } catch (e) {
      emailFunctionStatus =
          "${emailFunctionStatus}Try catch Error message on Appwrite Client setup.  The error is ${e.toString()}.  ";
    } finally {}
  }

  // Get the name and email of the newly created user from Appwrite's environment variable
  late DocumentList applicantUserlist;
  try {
    applicantUserlist = await database.listDocuments(
      databaseId: envVars['APPWRITE_DATABASE_ID']!,
      collectionId: envVars['APPWRITE_COLLECTION_ID']!,
      queries: [Query.limit(100)],
    );
  } catch (e) {
    emailFunctionStatus =
        "${emailFunctionStatus}Try catch Error message on Appwrite users list.  The error is ${e.toString()}.  ";
  }
  for (var applicantUser in applicantUserlist.documents) {
    String name = applicantUser.data['name'];
    String id = applicantUser.data['\$id'];
    if (name.contains(RegExp(r'test', caseSensitive: false))) {
      try {
        await database
            .deleteDocument(
                databaseId: envVars['APPWRITE_DATABASE_ID']!,
                collectionId: envVars['APPWRITE_COLLECTION_ID']!,
                documentId: id)
            .then((value) => emailFunctionStatus =
                "$emailFunctionStatus $id's with name $name is removed. ");
        accountDeteted = true;
      } on AppwriteException catch (e, st) {
        emailFunctionStatus =
            "${emailFunctionStatus}Try AppwriteException Error message user deletion : ${e.message} and ${st.toString()}.  ";
      } catch (dbError) {
        emailFunctionStatus =
            "${emailFunctionStatus}Try catch Error message user deletion : ${dbError.toString()}.  ";
      } finally {
        emailFunctionStatus = "${emailFunctionStatus}Completed the task.\n";
      }
    }
  }

  String text = emailFunctionStatus;

  final String apikey = envVars['SENDGRID_API_KEY']!;
  final String toAddressEnvVars = envVars['TO_ADDRESS']!;
  final String fromAddressEnvVars = envVars['FROM_ADDRESS']!;
  final String subjectEnvVars = envVars['EMAIL_SUBJECT']!;

  final mailer = Mailer(apikey);
  final toAddress = Address(toAddressEnvVars);
  final fromAddress = Address(fromAddressEnvVars);
  final content = Content('text/plain', text);
  final subject = subjectEnvVars;
  final personalization = Personalization([toAddress]);
  bool sendStatus = false;

  final sendgridEmail =
      Email([personalization], fromAddress, subject, content: [content]);
  if (accountDeteted) {
    try {
      emailFunctionStatus = "${emailFunctionStatus}Start to send email:  ";
      mailer.send(sendgridEmail);
      sendStatus = true;
    } catch (e) {
      emailFunctionStatus = "${emailFunctionStatus}Try catch Error message:";
    }
  }
  if (sendStatus) {
    emailFunctionStatus = "$emailFunctionStatus completed to send email:  ";
  }

  res.json({
    'data': emailFunctionStatus,
  });
}
