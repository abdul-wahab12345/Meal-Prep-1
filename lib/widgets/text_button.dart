import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class AtextButton extends StatelessWidget {
  const AtextButton({
    Key? key,
    required this.text,
    required this.callBack,
  }) : super(key: key);

  final String text;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: callBack,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: aTextButtonColor,fontWeight: FontWeight.bold),
      ),
    );
  }
}