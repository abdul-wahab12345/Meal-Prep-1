import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';

import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();

  void registerUser() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).signUp(
            userNameController.text,
            emailController.text,
            passwordController.text);

        setState(() {
          isLoading = false;
          emailController.clear();
          passwordController.clear();
          userNameController.clear();
        });
        showDialog(
          context: context,
          builder: (ctx) => AdaptiveDiaglog(
            ctx: ctx,
            title: 'User Created',
            content: 'Try login with new email and PassWord',
            btnYes: 'Okay',
            yesPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName,
              );
            },
          ),
        );
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'Error Occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = false;
                  });
                }));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

              Container(
                margin: EdgeInsets.only(bottom: height * 3, top: height * 5),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputFeild(
                        hinntText: 'Username',
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Enter username !";
                          }

                          return null;
                        },
                        inputController: userNameController,
                        textInputAction: TextInputAction.next,
                        focusNode: _usernameFocusNode,
                        submitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFocusNode);
                        },
                      ),
                      InputFeild(
                        hinntText: 'Email',
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Enter email address !";
                          }
                          if (!value.contains('@') || !value.contains('.com')) {
                            return "Enter a valid email address";
                          }

                          return null;
                        },
                        inputController: emailController,
                        textInputAction: TextInputAction.next,
                        focusNode: _emailFocusNode,
                        submitted: (_) {
                          FocusScope.of(context).requestFocus(_passFocusNode);
                        },
                      ),
                      InputFeild(
                        hinntText: 'Password',
                        secure: true,
                        validatior: (String value) {
                          if (value.isEmpty) {
                            return "Enter password";
                          }
                          if (value.length < 6) {
                            return "Must have 6 characters";
                          }
                          return null;
                        },
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
                  ? AdaptiveIndecator()
                  : CustomButton(
                      text: 'Register',
                      callback: registerUser,
                    ),

              Container(
                margin: EdgeInsets.only(top: height * 7, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AtextButton(
                      text: 'Back',
                      callBack: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LoginScreen.routeName);
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
