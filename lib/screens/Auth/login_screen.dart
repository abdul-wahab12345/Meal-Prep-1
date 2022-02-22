import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';

import 'package:mealprep/screens/Auth/forget_screen.dart';
import 'package:mealprep/screens/Auth/registeration_screen.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();

  // String modalData='';

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> tryLogin() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).userLogin(
          userNameController.text,
          passwordController.text,
        );

       
          //  Navigator.of(context).pushReplacementNamed(PlanScreen.routeName);

        Navigator.of(context).pushNamedAndRemoveUntil(
            PlanScreen.routeName, (Route<dynamic> route) => false);
      } catch (error) {
        print(error);
        await showDialog(
          context: context,
          builder: (ctx) {
            return AdaptiveDiaglog(
                ctx: ctx,
                content: error.toString(),
                title: 'An error has occured!',
                btnYes: 'Okay!',
                yesPressed: () {
                  Navigator.of(ctx).pop(true);
                });
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if(modalData==''){
    //    userNameController.text=modalData;

    // }
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    // modalData=ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: abackground,
      ),
      backgroundColor: abackground,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 7),
                height: height * 16,
                width: height * 16,
                child: Image.asset('assets/images/login_screen_image.png'),
              ), //Image Container
              SizedBox(
                height: height * 18,
              ),
              Container(
                margin: EdgeInsets.only(bottom: height * 5, top: height * 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputFeild(
                        hinntText: 'Username or email',
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Please enter username or email!";
                          }
                          return null;
                        },
                        inputController: userNameController,
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        submitted: (_) {
                          FocusScope.of(context).requestFocus(_passFocusNode);
                        },
                      ),
                      InputFeild(
                        hinntText: 'Password',
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Please enter password!";
                          }
                          return null;
                        },
                        secure: true,
                        inputController: passwordController,
                        textInputAction: TextInputAction.done,
                        focusNode: _passFocusNode,
                        submitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //TextFeild Container

              isLoading
                  ? Platform.isIOS
                      ? const CupertinoActivityIndicator(
                          radius: 30,
                        )
                      : const CircularProgressIndicator(
                          color: Colors.white,
                        )
                  : CustomButton(
                      text: 'Login',
                      callback: tryLogin,
                    ),

              Container(
                margin: EdgeInsets.only(top: height * 2, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AtextButton(
                      text: 'Forget Password',
                      callBack: () {
                        Navigator.of(context).pushNamed(ForgetScreen.routeName);
                      },
                    ),
                    AtextButton(
                      text: 'Register',
                      callBack: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
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
