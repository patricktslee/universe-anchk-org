import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:dart_appwrite/models.dart' as models;
import 'dart:io';
import 'package:sendgrid_mailer/sendgrid_mailer.dart';

Future<void> start(final req, final res) async {
  Map<String, String> envVars = Platform.environment;
  var emailFunctionStatus = 'Anonymous account cleanup Status: ';
  bool accountDeleted = false;

  Client client = Client();
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
    } catch (e) {
      emailFunctionStatus = emailFunctionStatus +
          "Try catch Error message on Appwrite Client setup.  The error is ${e.toString()}.  ";
    } finally {}
  }

  Users users = Users(client);
  late models.UserList userlist;
  try {
    userlist = await users.list(queries: [Query.limit(100)]);
  } catch (e) {
    emailFunctionStatus = emailFunctionStatus +
        "Try catch Error message on Appwrite users list.  The error is ${e.toString()}.  ";
  }

  DateTime last7DayOfToday =
      new DateTime.now().subtract(const Duration(days: 4));
  for (var user in userlist.users) {
    final String? email = user.email;
    final String? userId = user.$id;
    final String? registration = user.registration;
    DateTime registrationDate = DateTime.parse(registration!);

    if ((email == null || email.isEmpty) &&
        (registrationDate.compareTo(last7DayOfToday) < 0)) {
      //emailFunctionStatus = emailFunctionStatus +
      //    "${userId}'s email is empty (${email == null || email.isEmpty}). The registration Date is ${registrationDate.toIso8601String()} compare with last 7 Day Of Today ${last7DayOfToday.toIso8601String()} is ${(registrationDate.compareTo(last7DayOfToday) < 0)}.   Account is removed. \n";
      try {
        await users.delete(userId: userId!).then((value) =>
            emailFunctionStatus = emailFunctionStatus +
                "${userId}'s email is empty and account is removed. ");
        accountDeleted = true;
      } on AppwriteException catch (e, st) {
        emailFunctionStatus = emailFunctionStatus +
            "Try AppwriteException Error message user deletion : ${e.message} and ${st.toString()}.  ";
      } catch (dbError) {
        emailFunctionStatus = emailFunctionStatus +
            "Try catch Error message user deletion : ${dbError.toString()}.  ";
      } finally {
        emailFunctionStatus = emailFunctionStatus + "Completed the task.\n";
      }
    } else {
      //emailFunctionStatus = emailFunctionStatus +
      //    "${userId}'s email is not empty (${email == null || email.isEmpty}), registration Date is ${registrationDate.toIso8601String()} compare with last 7 Day Of Today ${last7DayOfToday.toIso8601String()} is ${(registrationDate.compareTo(last7DayOfToday) < 0)}. \n";
    }
  }
  emailFunctionStatus = emailFunctionStatus + "Completed to run.";
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

  final SendgridEmail =
      Email([personalization], fromAddress, subject, content: [content]);

  if (accountDeleted) {
    try {
      emailFunctionStatus = emailFunctionStatus + "Start to send email:  ";
      mailer.send(SendgridEmail);
      sendStatus = true;
    } catch (e) {
      emailFunctionStatus = emailFunctionStatus + "Try catch Error message:";
    }
    if (sendStatus) {
      emailFunctionStatus = emailFunctionStatus + "success message:  ";
    }
  }

  text = '';

  res.json(<String, dynamic>{"data": emailFunctionStatus});
}
