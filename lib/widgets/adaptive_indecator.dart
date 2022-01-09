import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIndecator extends StatelessWidget {
  Color color;

  AdaptiveIndecator({ this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ?const CupertinoActivityIndicator(radius: 20)
          : CircularProgressIndicator(
              color: color,
            ),
    );
  }
}
