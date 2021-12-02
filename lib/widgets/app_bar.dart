import 'package:flutter/material.dart';
import '../constant.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  CustomAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: aPrimary,
      leading: CircleAvatar(
        child: Image.asset('assets/images/alphatrait.png'),
      ),
      title: Text(title),
      actions: [
        CircleAvatar(
          child: Image.asset('assets/images/person.png'),
        )
      ],
    );
  }
}
