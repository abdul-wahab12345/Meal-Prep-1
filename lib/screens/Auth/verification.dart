import 'package:flutter/material.dart';
import 'package:mealprep/screens/Auth/change_password.dart';
import 'package:mealprep/screens/Auth/forget_screen.dart';

import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';

import '../../constant.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({Key? key}) : super(key: key);

  static const routeName = '/verification';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _codeFocusNode=FocusNode();

  var codeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _codeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        print(data['code']);

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      backgroundColor: abackground,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 12),
                height: height * 16,
                width: height * 16,
                child: Image.asset('assets/images/login_screen_image.png'),
              ), //Image Container
              Padding(
                padding: EdgeInsets.only(
                  top: height * 10,
                ),
                child: Text(
                  'Please enter the OTP sent on your email address',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),

              Form(
                key: _formKey,
                child: Container(
                  //width: width*80,
                  margin: EdgeInsets.only(bottom: height * 3, top: 0),
                  child: InputFeild(
                    hinntText: 'Enter Code',
                    type: TextInputType.number,
                    validatior: (String value) {
                      if (value.isEmpty) {
                        return "Please enter verification code!";
                      }
                      if (value.length > 6) {
                        return "Code contain only 6 charachters";
                      }
                      if (data['code'].toString() != codeController.text) {
                        return 'Invalid code';
                      } 
                      return null;
                    },
                    inputController: codeController,
                    focusNode: _codeFocusNode,
                    textInputAction: TextInputAction.done,
                    submitted: (_){},
                  ),
                ),
              ),
              //TextFeild Container

              Container(
                padding: EdgeInsets.symmetric(horizontal: width * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AtextButton(
                      text: 'Resend code',
                      callBack: () {},
                    ),
                    Container(
                      width: width * 40,
                      child: CustomButton(
                        text: 'Verify Code',
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                              Navigator.of(context)
                            .pushReplacementNamed(ChangePasswordScreen.routeName,arguments:data['email'].toString() );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: height * 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AtextButton(
                      text: 'Back',
                      callBack: () {
                        FocusScope.of(context).unfocus();
                        Navigator.of(context)
                            .pushReplacementNamed(ForgetScreen.routeName);
                      },
                    ),
                  ],
                ),
              ), //Text button Container
            ],
          ),
        ),
      ),
    );
  }
}
