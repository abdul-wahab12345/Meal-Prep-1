import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile-details';
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  int navBarIndex = 0;
  int profileTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height / 100;
    var width = queryData.size.width / 100;

    if (queryData.size.height < 700) {
      height = 700 / 100;
    }

     if (queryData.size.width > 550) {
      width = 550 / 100;
    }


var _appBar = AppBar(
    backgroundColor: aPrimary,
    
    title: Text("Profile"),
    actions: [
      Container(
         padding:EdgeInsets.all(8),
        child: CircleAvatar(
          child: Image.asset('assets/images/person.png'),
        ),
      )
    ],
  );

    return Scaffold(
      appBar: _appBar,
      backgroundColor: Color.fromRGBO(17, 17, 17, 1),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(38, 43, 55, 1),
          iconSize: 27,
          unselectedItemColor: Colors.white,
          selectedItemColor: Color.fromRGBO(142, 77, 255, 1),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.delivery_dining), label: "Delivery",),
            BottomNavigationBarItem(
                icon: Icon(Icons.next_plan_sharp), label: "Plans"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: "Profile"),
          ],
          currentIndex: navBarIndex,
          onTap: (index) {
            print(index);
            setState(() {
              print(index);
              navBarIndex = index;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: queryData.size.width > 550?550:double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: height * 2,
                ),
                Center(
                  child: Container(
                    height: height * 13,
                    width: height * 13,
                    child: Image.asset(
                      'assets/images/Image.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 2,
                ),
                Text(
                  'Abdul Wahab',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  width: double.infinity,
                  height: height * 5,
                  //padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(38, 43, 55, 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TabButton(
                        
                        () {
                          setState(() {
                            profileTabIndex = 0;
                          });
                        },
                        'Details',
                      
                        profileTabIndex == 0,
                        height,
                      ),
                      TabButton(
                        () {
                          setState(() {
                            profileTabIndex = 1;
                          });
                        },
                        'Payments',
                        profileTabIndex == 1,
                        height,
                      ),
                      TabButton(
                        () {
                          setState(() {
                            profileTabIndex = 2;
                          });
                        },
                        'Address',
                        profileTabIndex == 2,
                        height,
                      ),
                      TabButton(
                        () {
                          setState(() {
                            profileTabIndex = 3;
                          });
                        },
                        'Taste',
                        profileTabIndex == 3,
                        height,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: height * 2),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileInput("abd@gmail.com", height),
                        ProfileInput("Current Password", height),
                        ProfileInput("New Password", height),
                        ProfileInput("Confirm New Password", height),
                        Container(
                          margin: EdgeInsets.only(top: 27),
                          width: width * 45,
                          height: height * 6.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100)),
                          child: ElevatedButton(
                            clipBehavior: Clip.hardEdge,
                            onPressed: () {},
                            child: Text("Save Changes",style: Theme.of(context).textTheme.bodyText2,),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(142, 77, 255, 1),
                              ),
                              shape:
                                  MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileInput extends StatelessWidget {
  String hinntText;
  var height;
  ProfileInput(this.hinntText, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 6,
      margin: EdgeInsets.only(top: height * 2.5),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(18),
          hintStyle: TextStyle(color: Colors.white, fontSize: 14),
          hintText: hinntText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white, width: 2.0),
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
