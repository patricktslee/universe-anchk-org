import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:universe/constants/style.dart';
import 'package:universe/helpers/responsiveness.dart';
import 'package:universe/pages/home/presentation/controllers/home_controller.dart';
import 'package:universe/routing/routes.dart';
import 'package:universe/widgets/custom_text.dart';
//import 'package:url_launcher/url_launcher.dart';

class ApplicationWidget extends StatelessWidget {
  ApplicationWidget({Key? key}) : super(key: key);
  final logger = Logger(
    printer: PrettyPrinter(
        methodCount: 1,
        lineLength: 50,
        errorMethodCount: 3,
        colors: true,
        printEmojis: true),
  );
  static HomeController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final churchController = TextEditingController();
  final yearInHIMController = TextEditingController();
  final yearInBaptistController = TextEditingController();
  final churchServiceController = TextEditingController();
  final yearInChurchChoirController = TextEditingController();
  final otherChoirController = TextEditingController();
  final yearInOtherChoirController = TextEditingController();
  final partController = TextEditingController();
  final musicTalentController = TextEditingController();
  final otherTalentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _applicationTest(context),
            _applicationButton(),
          ],
        ),
      ),
    );
  }

  Widget _applicationTest(BuildContext context) => Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFeildInput(
              customController: nameController,
              customHintText: "??????",
              customIcon: const Icon(Icons.person),
              isRequired: true,
            ),
            CustomPhoneFeildInput(
              customController: phoneController,
              customHintText: "????????????",
              customIcon: const Icon(Icons.phone),
            ),
            CustomEmailFeildInput(
              customController: emailController,
              customHintText: "??????",
              customIcon: const Icon(Icons.email),
            ),
            CustomGenderFeildInput(
              customController: genderController,
              customHintText: "??????",
              customIcon: const Icon(Icons.person_search),
            ),
            CustomTextFeildInput(
              customController: churchController,
              customHintText: "????????????",
              customIcon: const Icon(Icons.people_rounded),
              isRequired: true,
            ),
            CustomNumberFeildInput(
              customController: yearInHIMController,
              customHintText: "????????????",
              customIcon: const Icon(Icons.trending_up),
              isRequired: true,
            ),
            CustomNumberFeildInput(
              customController: yearInBaptistController,
              customHintText: "??????????????????",
              customIcon: const Icon(Icons.water),
              isRequired: true,
            ),
            CustomTextFeildInput(
              customController: churchServiceController,
              customHintText: "??????????????????",
              customIcon: const Icon(Icons.miscellaneous_services),
              isRequired: false,
            ),
            CustomNumberFeildInput(
              customController: yearInChurchChoirController,
              customHintText: "??????????????????",
              customIcon: const Icon(Icons.verified),
              isRequired: false,
            ),
            CustomTextFeildInput(
              customController: otherChoirController,
              customHintText: "???????????????????????????",
              customIcon: const Icon(Icons.near_me),
              isRequired: false,
            ),
            CustomNumberFeildInput(
              customController: yearInOtherChoirController,
              customHintText: "???????????????????????????",
              customIcon: const Icon(Icons.mouse_rounded),
              isRequired: false,
            ),
            CustomPartsFieldInput(
              customController: partController,
              customHintText: "??????",
              customIcon: const Icon(Icons.person_search),
            ),
            CustomTextFeildInput(
              customController: musicTalentController,
              customHintText: "?????????????????????/?????????",
              customIcon: const Icon(Icons.piano),
              isRequired: false,
            ),
            CustomTextFeildInput(
              customController: otherTalentController,
              customHintText: "????????????",
              customIcon: const Icon(Icons.work_sharp),
              isRequired: false,
            ),
          ],
        ),
      );

  Widget _applicationButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ElevatedButton(
          onPressed: () async {
//            String body = "";

            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
//                    body =
//                        '??????:${nameController.text.toString()};????????????:${phoneController.text.toString()};??????:${emailController.text.toString()};??????:${genderController.text.toString()};????????????:${churchController.text.toString()};????????????:${yearInHIMController.text.toString()};??????????????????:${yearInBaptistController.text.toString()};??????????????????:${churchServiceController.text.toString()};??????????????????:${yearInChurchChoirController.text.toString()};???????????????????????????:${otherChoirController.text.toString()};???????????????????????????:${yearInOtherChoirController.text.toString()};??????:${partController.text.toString()};?????????????????????/?????????:${musicTalentController.text.toString()};????????????:${otherTalentController.text.toString()};Thank You!';
              Map<dynamic, dynamic> data = {
                "name": nameController.text.toString(),
                "phone": phoneController.text.toString(),
                "email": emailController.text.toString(),
                "gender": genderController.text.toString(),
                "church": churchController.text.toString(),
                "yearInHIM": yearInHIMController.text.toString(),
                "yearInBaptist": yearInBaptistController.text.toString(),
                "churchService": churchServiceController.text.toString(),
                "yearInChurchChoir":
                    yearInChurchChoirController.text.toString(),
                "otherChoir": otherChoirController.text.toString(),
                "yearInOtherChoir": yearInOtherChoirController.text.toString(),
                "part": partController.text.toString(),
                "musicTalent": musicTalentController.text.toString(),
                "otherTalent": otherTalentController.text.toString(),
              };
              //body = '''
              //          ??????:${nameController.text.toString()};
              //          ????????????:${phoneController.text.toString()};
              //          ??????:${emailController.text.toString()};
              //          ??????:${genderController.text.toString()};
              //          ????????????:${churchController.text.toString()};
              //          ????????????:${yearInHIMController.text.toString()};
              //          ??????????????????:${yearInBaptistController.text.toString()};
              //          ??????????????????:${churchServiceController.text.toString()};
              //          ??????????????????:${yearInChurchChoirController.text.toString()};
              //          ???????????????????????????:${otherChoirController.text.toString()};
              //          ???????????????????????????:${yearInOtherChoirController.text.toString()};
              //          ??????:${partController.text.toString()};
              //          ?????????????????????/?????????:${musicTalentController.text.toString()};
              //          ????????????:${otherTalentController.text.toString()};
              //          Thank You!''';
//
              //ScaffoldMessenger.of(context).showSnackBar(
              //  SnackBar(
              //      content: CustomText(
              //          text: '??????????????????',
              //          size: 24,
              //          color: dark,
              //          weight: FontWeight.normal)),
              //);
              logger.i('data is $data');
              logger.i('login status is ${controller.loginStatus.value}');
              controller.createApplication(data);
//              logger.i('body is $body');
//              if (await canLaunch('mailto:info@anchk.org')) {
//                await launch(
//                    'mailto:info@anchk.org?subject=???????????????????????????????????????&body=$body');
//              } else {
//                throw 'Could not launch info@anchk.org';
//              }

              controller.changeActiveItemTo(introductionPageDisplayName);
              controller.navigateTo(introductionPageRoute);
            }
          },
          child: CustomText(
              text: '???????????????',
              size: standardTextSize,
              color: dark,
              weight: FontWeight.normal),
        ),
      );
}

InputDecoration customInputDecoration(
        String customHintText, BuildContext context) =>
    InputDecoration(
      hintText: customHintText,
      hintStyle: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: ResponsiveWidget.isSmallScreen(context)
              ? 16
              : ResponsiveWidget.isMediumScreen(context)
                  ? 18
                  : 24, // default is 16,
          color: dark, // default is Colors.black,
          fontWeight: FontWeight.normal),
      errorStyle: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: ResponsiveWidget.isSmallScreen(context)
              ? 16
              : ResponsiveWidget.isMediumScreen(context)
                  ? 18
                  : 24, // default is 16,
          color: Colors.red, // default is Colors.black,
          fontWeight: FontWeight.normal),
    );

EdgeInsets customFormEdgeInsets() =>
    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0);

class CustomTextFeildInput extends StatelessWidget {
  const CustomTextFeildInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
    required this.isRequired,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          style: const TextStyle(fontFamily: 'NotoSans'),
          validator: (value) {
            if (isRequired) {
              if (value == null || value.isEmpty) {
                return '???????????????';
              }
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}
//https://protocoderspoint.com/flutter-form-validation-email-validate-password-confirm/

class CustomEmailFeildInput extends StatelessWidget {
  const CustomEmailFeildInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '???????????????';
            }
            if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                .hasMatch(value)) {
              return '??????????????????????????????';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomPasswordFeildInput extends StatelessWidget {
  const CustomPasswordFeildInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '?????????';
            }
            if (value.length < 8) {
              return '????????????????????? 8 ?????????';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomConfirmedPasswordFeildInput extends StatelessWidget {
  const CustomConfirmedPasswordFeildInput({
    Key? key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.customHintText,
    required this.customIcon,
  }) : super(key: key);

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '?????????';
            }
            if (confirmPasswordController.text != passwordController.text) {
              return '???????????????????????????';
            }
            return null;
          },
          controller: confirmPasswordController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomGenderFeildInput extends StatefulWidget {
  const CustomGenderFeildInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;

  @override
  State<CustomGenderFeildInput> createState() => _CustomGenderFeildInputState();
}

class _CustomGenderFeildInputState extends State<CustomGenderFeildInput> {
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => widget.customController.text = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: widget.customIcon,
        title: Row(
          children: [
            MyRadioOption<String>(
              value: 'M',
              groupValue: widget.customController.text,
              onChanged: _valueChangedHandler(),
              label: '???',
              text: '???',
            ),
            MyRadioOption<String>(
              value: 'F',
              groupValue: widget.customController.text,
              onChanged: _valueChangedHandler(),
              label: '???',
              text: '???',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomPartsFieldInput extends StatefulWidget {
  const CustomPartsFieldInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;

  @override
  State<CustomPartsFieldInput> createState() => _CustomPartsFieldInputState();
}

class _CustomPartsFieldInputState extends State<CustomPartsFieldInput> {
  ValueChanged<String?> _valueChangedHandler() {
    return (value) => setState(() => widget.customController.text = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: widget.customIcon,
        title: Column(
          children: [
            Row(
              children: [
                MyRadioOption<String>(
                  value: 'S',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '??????',
                  text: '??????',
                ),
                MyRadioOption<String>(
                  value: 'A',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '??????',
                  text: '??????',
                ),
              ],
            ),
            Row(
              children: [
                MyRadioOption<String>(
                  value: 'T',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '??????',
                  text: '??????',
                ),
                MyRadioOption<String>(
                  value: 'B',
                  groupValue: widget.customController.text,
                  onChanged: _valueChangedHandler(),
                  label: '??????',
                  text: '??????',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNumberFeildInput extends StatelessWidget {
  const CustomNumberFeildInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
    required this.isRequired,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  final bool isRequired;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            if ((isRequired) && (value == null || value.isEmpty)) {
              return '???????????????';
            }
            final n = num.tryParse(value!);
            if ((value.isNotEmpty) && (n == null)) {
              return '???????????????';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class CustomPhoneFeildInput extends StatelessWidget {
  const CustomPhoneFeildInput({
    Key? key,
    required this.customController,
    required this.customHintText,
    required this.customIcon,
  }) : super(key: key);

  final TextEditingController customController;
  final String customHintText;
  final Icon customIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customFormEdgeInsets(),
      child: ListTile(
        leading: customIcon,
        title: TextFormField(
          keyboardType: TextInputType.number,
          validator: (value) {
            String pattern = r'(^[2-9][0-9]{7}$)';
            if (value == null || value.isEmpty) {
              return '???????????????';
            }
            final n = num.tryParse(value);
            if (n == null) {
              return '???????????????';
            }
            if ((!RegExp(pattern).hasMatch(value))) {
              return '??????????????????????????????';
            }
            return null;
          },
          controller: customController,
          decoration: customInputDecoration(customHintText, context),
        ),
      ),
    );
  }
}

class MyRadioOption<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final String label;
  final String text;
  final ValueChanged<T?> onChanged;

  const MyRadioOption({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  Widget _buildLabel(BuildContext context) {
    final bool isSelected = value == groupValue;

    return Container(
      width: ResponsiveWidget.isSmallScreen(context)
          ? 27
          : ResponsiveWidget.isMediumScreen(context)
              ? 29
              : 36,
      height: ResponsiveWidget.isSmallScreen(context)
          ? 27
          : ResponsiveWidget.isMediumScreen(context)
              ? 29
              : 36,
      decoration: ShapeDecoration(
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        color: isSelected ? Colors.cyan : Colors.white,
      ),
      child: Center(
          child: CustomText(
              text: value.toString(),
              size: standardTextSize,
              color: isSelected ? Colors.white : dark,
              weight: FontWeight.normal)
          //Text(
          //  value.toString(),
          //  style: TextStyle(
          //    fontFamily: 'NotoSans',
          //    color: isSelected ? Colors.white : dark,
          //    fontSize: ResponsiveWidget.isSmallScreen(context)
          //        ? 14
          //        : ResponsiveWidget.isMediumScreen(context)
          //            ? 16
          //            : 22,
          //  ),
          //),
          ),
    );
  }

  Widget _buildText(BuildContext context) {
    return CustomText(
        text: text,
        size: standardTextSize,
        color: Colors.black,
        weight: FontWeight.normal);
    //Text(
    //  text,
    //  style: TextStyle(
    //    fontFamily: 'NotoSans',
    //    color: Colors.black,
    //    fontSize: ResponsiveWidget.isSmallScreen(context)
    //        ? 16
    //        : ResponsiveWidget.isMediumScreen(context)
    //            ? 18
    //            : 24,
    //  ),
    //);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => onChanged(value),
        splashColor: Colors.cyan.withOpacity(0.5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              _buildLabel(context),
              const SizedBox(width: 10),
              _buildText(context),
            ],
          ),
        ),
      ),
    );
  }
}
