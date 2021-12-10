import 'package:flutter/material.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/screens/add_plan_screen.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/widgets/bottom_bar.dart';

import '../constant.dart';

class PlanScreen extends StatelessWidget {
  static const routeName = '/plans_screen';
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subscrip = Subscriptions();
    List<Subscription> subs = subscrip.subscriptions;

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    if (currentOrientation == Orientation.landscape) {
      width = 550 / 100;
      
     
    }
    var _appBar = AppBar(
      backgroundColor: aPrimary,
      leading: Container(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          child: Image.asset('assets/images/alphatrait.png'),
        ),
      ),
      title: const Text("My Plans"),
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
      backgroundColor: Colors.black,
      appBar: _appBar,
      bottomNavigationBar: BottomNavBar(),
      body: Container(
        
        width:
            currentOrientation == Orientation.landscape ? 550 : double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * 70,
                // margin: EdgeInsets.symmetric(
                //   vertical: 10,
                // ),
                child: ListView.builder(
                  itemCount: subs.length,
                  itemBuilder: (ctx, index) => Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      color: aPrimary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: width * 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(subs[index].title,
                                  style: Theme.of(context).textTheme.headline6),
                              SizedBox(
                                height: height * 3,
                              ),
                              Text('Next Deilivery'),
                              SizedBox(
                                height: height * 0.2,
                              ),
                              Text(
                                subs[index].nextDelivery,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height: height * 5,
                              ),
                              Text(
                                subs[index].status,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(),
                              ),
                            ],
                          ),
                        ), //ContentConatiner
                        Container(
                          width: width * 35,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Image.network(subs[index].imageUrl,
                              fit: BoxFit.cover),
                        ), //imageContainer
                      ],
                    ),
                  ),
                ),
              ), //Listview end
              // SizedBox(height: height*8,),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(AddPlan.routeName);
                },
                child: Container(
                  height: height * 5.5,
                  width: width * 60,
                  padding: EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    //color: Colors.purple,
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      gra1,
                      gra2,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Text(
                    'Add New plan',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
