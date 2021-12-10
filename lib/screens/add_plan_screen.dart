import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile_screen.dart';
class AddPlan extends StatelessWidget {
  static const routeName='/addPlan';
  const AddPlan({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _appBar = AppBar(
      backgroundColor: aPrimary,
     
      title: const Text("Add Plan"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              child: Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: _appBar,

      body: Center(child: Text('Mac Mini',style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),)),
      
    );
  }
}