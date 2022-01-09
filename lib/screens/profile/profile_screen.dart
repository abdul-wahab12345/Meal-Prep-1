import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/user.dart';

import 'package:mealprep/screens/profile/address.dart';
import 'package:mealprep/screens/profile/payment.dart';
import 'package:mealprep/screens/profile/taste.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';

import 'package:mealprep/widgets/input_feild.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile-details';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var emailController = TextEditingController();
  var currentPass = TextEditingController();
  var newPass = TextEditingController();
  var confirmPass = TextEditingController();
  bool isFirst = true;

  final _formKey = GlobalKey<FormState>();

  // User? curr;

  int profileTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState

    var user = Provider.of<UserData>(context, listen: false).user;
    if (user == null) {
      Provider.of<UserData>(context, listen: false)
          .getUserData()
          .catchError((error) {
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'An Error Occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    //to stop loading
                  });
                }));
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context).user;

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height / 100;
    var width = queryData.size.width / 100;

    if (queryData.size.height < 700) {
      height = 700 / 100;
    }

    if (queryData.size.width > 550) {
      width = 550 / 100;
    }

    List<Widget> tabs = [
      UserFields(
          height: height,
          formKey: _formKey,
          emailController: emailController,
          currentPass: currentPass,
          newPass: newPass,
          confirmPass: confirmPass,
          width: width),
      PaymentTab(height: height),
      AddressTab(),
      TasteTab(),
    ];

    return user == null
        ? Center(
            child: AdaptiveIndecator(),
          )
        : SingleChildScrollView(
            child: Center(
            child: Container(
              width: queryData.size.width > 550 ? 550 : double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 2,
                  ),
                  Center(
                    child: Container(
                      height: height * 13,
                      width: height * 13,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          user.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 2,
                  ),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    width: double.infinity,
                    height: height * 5,
                    //padding: EdgeInsets.all(10),
                    margin:const EdgeInsets.only(left: 10, right: 10, top: 20),
                    decoration: BoxDecoration(
                        color:const Color.fromRGBO(38, 43, 55, 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabButton(
                          onTap: () {
                            setState(() {
                              profileTabIndex = 0;
                            });
                          },
                          text: 'Details',
                          isActive: profileTabIndex == 0,
                          height: height,
                        ),
                        TabButton(
                          onTap: () {
                            setState(() {
                              profileTabIndex = 1;
                            });
                          },
                          text: 'Payments',
                          isActive: profileTabIndex == 1,
                          height: height,
                        ),
                        TabButton(
                          onTap: () {
                            setState(() {
                              profileTabIndex = 2;
                            });
                          },
                          text: 'Address',
                          isActive: profileTabIndex == 2,
                          height: height,
                        ),
                        TabButton(
                          onTap: () {
                            setState(() {
                              profileTabIndex = 3;
                            });
                          },
                          text: 'Taste',
                          isActive: profileTabIndex == 3,
                          height: height,
                        ),
                      ],
                    ),
                  ),
                  tabs[profileTabIndex],
                ],
              ),
            ),
          ));
  }
}

class UserFields extends StatefulWidget {
  const UserFields({
    Key? key,
    required this.height,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.currentPass,
    required this.newPass,
    required this.confirmPass,
    required this.width,
  })  : _formKey = formKey,
        super(key: key);

  final double height;
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController currentPass;
  final TextEditingController newPass;
  final TextEditingController confirmPass;
  final double width;

  @override
  State<UserFields> createState() => _UserFieldsState();
}

class _UserFieldsState extends State<UserFields> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context).user;
    if (user != null) {
      widget.emailController.text = user.email;
    }

    void changePassword() async {
      if (widget._formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });
        var response = await Provider.of<Auth>(context, listen: false)
            .changePassWord(
                user!.email, widget.currentPass.text, widget.newPass.text);
        print(response);
        if (response['status'] == 'error') {
          showDialog(
              context: context,
              builder: (ctx) => AdaptiveDiaglog(
                  ctx: ctx,
                  title: 'An error occurred',
                  content: response['message'].toString(),
                  btnYes: 'Okay',
                  yesPressed: () {
                    Navigator.of(context).pop();
                  }));
        } else {
          showDialog(
              context: context,
              builder: (ctx) => AdaptiveDiaglog(
                  ctx: ctx,
                  title: 'Success',
                  content: 'Password changed',
                  btnYes: 'Okay',
                  yesPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      widget.currentPass.clear();
                      widget.newPass.clear();
                      widget.confirmPass.clear();
                    });
                  }));
        }
        setState(() {
          isLoading = false;
        });
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: widget.height * 4),
      child: Form(
        key: widget._formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputFeild(
              readOnly: true,
              hinntText: "abd@gmail.com",
              validatior: (String value) {
                if (value.isEmpty) {
                  return "Please enter your email!";
                }
                if (!value.contains('@') || !value.contains('.com')) {
                  return "Enter a valid email address";
                }
                return null;
              },
              inputController: widget.emailController,
            ),
            InputFeild(
              hinntText: "Current Password",
              validatior: (String value) {
                if (value.isEmpty) {
                  return "Please enter current password!";
                }

                return null;
              },
              secure: true,
              inputController: widget.currentPass,
            ),
            InputFeild(
              hinntText: "New Password",
              secure: true,
              validatior: (String value) {
                if (value.isEmpty) {
                  return "Please enter new password!";
                }
                if (value.length < 6) {
                  return "Must have 6 characters !";
                }

                return null;
              },
              inputController: widget.newPass,
            ),
            InputFeild(
              hinntText: "Confirm New Password",
              secure: true,
              validatior: (String value) {
                if (value.isEmpty) {
                  return "Please enter new password!";
                }
                if (widget.newPass.text != value) {
                  return "Password didn't match";
                }
                return null;
              },
              inputController: widget.confirmPass,
            ),
            isLoading
                ? Container(
                    margin:const EdgeInsets.only(
                      top: 20,
                    ),
                    child: AdaptiveIndecator())
                : AuthButton(
                    width: widget.width,
                    height: widget.height,
                    text: 'Save Changes',
                    callback: changePassword,
                  ),
          ],
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  AuthButton(
      {Key? key,
      required this.width,
      required this.height,
      required this.text,
      required this.callback})
      : super(key: key);

  final double width;
  final double height;
  final String text;
  Function callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 27),
      width: width * 45,
      height: height * 6.5,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: () => callback(),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
           const Color.fromRGBO(142, 77, 255, 1),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  VoidCallback onTap;
  bool isActive;
  String text;
  var height;
  TabButton({
    required this.onTap,
    required this.text,
    required this.isActive,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: height * 1),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.black : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }
}
