import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class AdaptiveDiaglog extends StatelessWidget {
  BuildContext ctx;
  String? content;
  String title;
  String btnYes;
  String btnNO;
  Function yesPressed;
  Function? noPressed;

  AdaptiveDiaglog({
    required this.ctx,
     this.content='',
    required this.title,
    required this.btnYes,
     this.btnNO='',
    required this.yesPressed,
    this.noPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(content!),
            actions: [
              CupertinoDialogAction(
                child: Text(btnYes),
                onPressed: yesPressed as Function()?,
              ),
              if(btnNO!='')
              CupertinoDialogAction(
                child: Text(btnNO),
                onPressed: noPressed as Function()?,
              ),
            ],
          )
        : AlertDialog(
            title: Text(title,
                style:const TextStyle(
                  color: Colors.black,
                )),
            content: Text(content!,style:const TextStyle(color: Colors.black),),
            actions: [
              TextButton(
                child: Text(btnYes,style: TextStyle(color: aTextButtonColor),),
                onPressed: yesPressed as Function()?,
              ),
              if(btnNO!='')
              TextButton(
                child: Text(btnNO,style: TextStyle(color: aTextButtonColor),),
                onPressed: noPressed as Function()?,
              ),
            ],
          );
  }
}
