import 'package:dart_appwrite/dart_appwrite.dart';
import 'dart:convert';
import 'dart:io';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

Future<void> start(final req, final res) async {
  Map<String, String> envVars = Platform.environment;
  var emailFunctionStatus = 'Sendgrid Email Function Status: ';

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
      emailFunctionStatus = emailFunctionStatus +
          "Try catch Error message on Appwrite Client setup.  The error is ${e.toString()}.  ";
    } finally {}
  }

  // Get the name and email of the newly created user from Appwrite's environment variable

  final payload = jsonDecode(envVars['APPWRITE_FUNCTION_EVENT_DATA']!);

  String text = '''收到${payload['name']}申請參加萬國宣道詠團 😍\n
        姓名: ${payload['name']}
        聯絡電話: ${payload['phone']}
        電郵: ${payload['email']}
        性別: ${payload['gender']}
        所屬教會: ${payload['church']}
        信主年齡: ${payload['yearInHIM']}
        接受浸禮年份: ${payload['yearInBaptist']}
        教會事奉經驗: ${payload['churchService']}
        教會詩班年齡: ${payload['yearInChurchChoir']}
        參加其他合唱團名稱: ${payload['otherChoir']}
        其他合唱團詩班年齡: ${payload['yearInOtherChoir']}
        聲部: ${payload['part']}
        音樂專長（指揮/樂器）: ${payload['musicTalent']}
        其他專長: ${payload['otherTalent']}
        Thank you!''';

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

  final SendgridEmail =
      Email([personalization], fromAddress, subject, content: [content]);
  try {
    emailFunctionStatus = emailFunctionStatus + "Start to send email:  ";
    mailer.send(SendgridEmail);
    sendStatus = true;
  } catch (e) {
    emailFunctionStatus = emailFunctionStatus + "Try catch Error message:";
  }

  if (sendStatus) {
    emailFunctionStatus = emailFunctionStatus + "success message:  ";
    try {
      await database.updateDocument(
        collectionId: payload['\$collectionId'],
        documentId: payload['\$id'],
        data: {'isEmail': true},
        databaseId: payload['\$databaseId'],
      );
      emailFunctionStatus = emailFunctionStatus + "success update database:  ";
    } on AppwriteException catch (e, st) {
      emailFunctionStatus = emailFunctionStatus +
          "Try AppwriteException Error message database update by payload info ${payload.toString()} : ${e.message} and ${st.toString()}.  ";
    } catch (dbError) {
      emailFunctionStatus = emailFunctionStatus +
          "Try catch Error message database update by payload info ${payload.toString()} : ${dbError.toString()}.  ";
    } finally {
      emailFunctionStatus = emailFunctionStatus + "Completed the task.";
    }
  }

  res.json({
    'data': "$emailFunctionStatus",
  });
}
