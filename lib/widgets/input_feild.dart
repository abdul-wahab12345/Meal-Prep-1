import 'package:flutter/material.dart';

class InputFeild extends StatefulWidget {
  String hinntText;

  Function validatior;
  TextEditingController inputController;
  TextInputType? type;
  bool secure = true;
  bool readOnly;

  InputFeild(
      {required this.hinntText,
      required this.validatior,
      required this.inputController,
      this.type,
      this.readOnly = false,
      this.secure = false});

  @override
  State<InputFeild> createState() => _InputFeildState();
}

class _InputFeildState extends State<InputFeild> {
  var isError = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
     if (height < 700) {
      height = 700 / 100;
    }
    return Container(
      height: isError ? height * 9 : height *7,
      margin: EdgeInsets.only(top: height * 3),
      child: TextFormField(
        obscureText: widget.secure,
        readOnly: widget.readOnly,
        keyboardType: widget.type,
        controller: widget.inputController,
        validator: (value) {
          var error = widget.validatior(value);
          if (error != null) {
            setState(() {
              isError = true;
            });
          }else{
            setState(() {
              isError = false;
            });
          }
           
          return error;
        },
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(18),
            hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
            hintText: widget.hinntText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
            errorStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Colors.red, fontSize: 11)),
      ),
    );
  }
}
