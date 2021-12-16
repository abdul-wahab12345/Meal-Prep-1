import 'package:flutter/material.dart';

import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:mealprep/widgets/text_button.dart';

class ForgetScreen extends StatelessWidget {
  static const routeName = '/forget';

  var _formKey = GlobalKey<FormState>();

  ForgetScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: abackground,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: height * 12),
                height: height * 16,
                width: height * 16,
                child: Image.asset('assets/images/login_screen_image.png'),
              ), //Image Container

              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(bottom: height * 3, top: height * 5),
                  child: InputFeild(
                    hinntText: 'Email',
                    validatior: (String value) {
                      if (value.isEmpty) {
                        return "Please enter your email!";
                      }
                      if (!value.contains('@') || !value.contains('.com')) {
                        return "Enter a valid email address";
                      }
                      return null;
                    },
                    inputController: emailController,
                  ),
                ),
              ),
              //TextFeild Container

              CustomButton(
                text: 'Reset Password',
                callback: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
              ),

              Container(
                margin: EdgeInsets.only(top: height * 10, left: 20, right: 20),
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
