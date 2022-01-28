import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/screens/Auth/change_password.dart';

import 'package:mealprep/screens/Auth/forget_screen.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';

import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({Key? key}) : super(key: key);

  static const routeName = '/verification';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _codeFocusNode = FocusNode();
  bool isLoading = false;
  bool isResend = false;

  final codeController = TextEditingController();
  String email = '';

  @override
  void dispose() {
    codeController.dispose();
    _codeFocusNode.dispose();
    super.dispose();
  }

  void reSendCode() async {
    FocusScope.of(context).unfocus();

    setState(() {
      isResend = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).resetPassword(email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email Sent'),
        ),
      );

      setState(() {
        isResend = false;
      });
    } catch (error) {
      setState(() {
        isResend = false;
      });
      showDialog(
          context: context,
          builder: (ctx) => AdaptiveDiaglog(
              ctx: ctx,
              title: 'An error occurred',
              content: error.toString(),
              btnYes: 'Okay',
              yesPressed: () {
                Navigator.of(context).pop();
              }));
    }
  }

  void tryVerify() async {
    if (_formKey.currentState!.validate()) {
      setState(
        () {
          isLoading = true;
        },
      );
      try {
        await Provider.of<Auth>(context, listen: false).verifyPassword(
          codeController.text,
          email,
        );
        setState(() {
          isLoading = false;
        });

        Navigator.of(context)
            .pushReplacementNamed(ChangePasswordScreen.routeName, arguments: {
          'email': email,
          'code': codeController.text,
        });
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'An Error Occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments.toString();

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
              ),
              SizedBox(
                height: height * 25,
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

                      return null;
                    },
                    inputController: codeController,
                    focusNode: _codeFocusNode,
                    textInputAction: TextInputAction.done,
                    submitted: (_) {},
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
                    isResend
                        ? AdaptiveIndecator()
                        : AtextButton(
                            text: 'Resend code',
                            callBack: reSendCode,
                          ),
                    Container(
                      width: width * 40,
                      child: isLoading
                          ? AdaptiveIndecator()
                          : CustomButton(
                              text: 'Verify Code',
                              callback: tryVerify,
                            ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: height * 3, left: 20, right: 20),
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
