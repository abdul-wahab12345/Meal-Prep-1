import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/auth_button.dart';

class AddNote extends StatelessWidget {
   AddNote({Key? key}) : super(key: key);
  static const routeName = '/add_note';
  var _formKey=GlobalKey<FormState>();
  var noteContrller=TextEditingController();
   

  void _trySubmit(){
    bool isvalid;
    if(_formKey.currentState!.validate()){
        isvalid=true;
    }
    if(isvalid=true){
       _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
     Orientation currentOrientation = MediaQuery.of(context).orientation;
     
    var height=MediaQuery.of(context).size.height/100;
    var width=MediaQuery.of(context).size.width/100;
    if(currentOrientation==Orientation.landscape){
      height=600/100;
    }
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text("Add Note"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName,arguments: 2);
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
      backgroundColor: Colors.black,
      appBar: _appBar,
      body: Center(
        heightFactor: 1,
        child: Container(
          width: currentOrientation==Orientation.landscape?600:double.infinity,
          //height: currentOrientation==Orientation.landscape?200:,
          margin: EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                
                  
                  children: [
                    
                      //margin: EdgeInsets.only(top: 200),
                      Container(
                        margin: EdgeInsets.only(top: height*20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: aPrimary,
                        ),
                        padding: EdgeInsets.only(top: height*8, left: 30, right: 30),
                        height:height*37,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                          
                            
                            validator: (value){
                              if(value!.isEmpty){
                                 return 'Please add a note then press button!';
                              }
          
                            },
                            onSaved: (value){
                                print(value);
                            },
                            controller: noteContrller,
                            maxLines: 6,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              
                              hintText: 'Click Here to add order note',
                              hintStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(fontSize: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:Colors.transparent,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                                
                              ),
                        
                            ),
                          ),
                        ),
                      
                    ),
                    Positioned(
                      left:width*20,
                      bottom: height*27,
                      child: Container(
                        child: Image.asset('assets/images/vegan.png'),
                      ),
                    ),//imageConatiner
                  ],
                ),
             
                Container(
                  width: currentOrientation==Orientation.landscape?width*30: width*50,
                  height: currentOrientation==Orientation.landscape?height*15: height*8,
                  
                  //alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: CustomButton(text: 'Save Changes', callback:_trySubmit),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
