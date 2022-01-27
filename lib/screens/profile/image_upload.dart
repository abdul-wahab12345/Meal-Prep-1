import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class ImageUpload extends StatefulWidget {
  static const routeName = 'image-upload';
  String? base64Image;
  File? image;
  ImageUpload({this.base64Image, this.image});

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    void upload() {
      setState(() {
        isLoading = true;
      });
      String fileName = widget.image!.path.split('/').last;

      Provider.of<UserData>(context, listen: false)
          .changeProfileImage(widget.base64Image!)
          .then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop(true);
      }).catchError((error) {
        setState(() {
          isLoading = false;
        });
        showDialog(
            context: context,
            builder: (ctx) {
              return AdaptiveDiaglog(
                  ctx: ctx,
                  title: 'An error occured',
                  btnYes: 'Okay',
                  yesPressed: () {
                    Navigator.of(context).pop(true);
                  });
            });
      });
    }
var user = Provider.of<UserData>(context).user;
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text("Change Image"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName, arguments: 2);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
               child: user != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              user.imageUrl,
                              height: 40,
                              fit: BoxFit.cover,
                            ))
                        : Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.image != null)
                Container(
                  height: 300,
                  child: Image.file(widget.image!),
                ),
              SizedBox(
                height: 15,
              ),
              if (widget.image != null)
                isLoading
                    ? AdaptiveIndecator()
                    : CustomButton(text: 'Upload', callback: upload)
            ],
          ),
        ),
      ),
    );
  }
}
