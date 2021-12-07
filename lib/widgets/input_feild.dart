import 'package:flutter/material.dart';

class InputFeild extends StatelessWidget {
  String hinntText;
  var height;
  InputFeild(this.hinntText, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 6,
      margin: EdgeInsets.only(top: height * 2.5),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(18),
          hintStyle:const TextStyle(color: Colors.white, fontSize: 14),
          hintText: hinntText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:const BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:const BorderSide(color: Colors.white, width: 2.0),
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
  TabButton(this.onTap, this.text, this.isActive, this.height);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: height * 1),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
              color: isActive ? Colors.black : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,letterSpacing: .5,),
        ),
      ),
    );
  }
}
