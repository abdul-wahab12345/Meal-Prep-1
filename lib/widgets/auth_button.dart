

import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
   
    required this.text,
    required this.callback,
  }) : super(key: key);

 
  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {

   var height= MediaQuery.of(context).size.width/100;
   var width= MediaQuery.of(context).size.height/100;
    return Container(
      
      width: width*30,
      height:height*12,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100)),
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        onPressed: callback,
        child: Text(text,style: Theme.of(context).textTheme.bodyText2,),
        style: ButtonStyle(
          
          backgroundColor: MaterialStateProperty.all<Color>(
           const Color.fromRGBO(142, 77, 255, 1),
            
          ),
          shape:
              MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
      ),
    );
  }
}
