import 'package:flutter/material.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/screens/Plans/variations_plan_screen.dart';
import 'package:provider/provider.dart';

class AddPlan extends StatefulWidget {
  static const routeName = '/addPlan';
  const AddPlan({Key? key}) : super(key: key);

  @override
  State<AddPlan> createState() => _AddPlanState();
}

class _AddPlanState extends State<AddPlan> {
List<Product> prod = [];
@override
  void initState() {

// Future.delayed(Duration.zero).then((value) {
//   Provider.of<Products>(context,listen: false).fetchAndSetProducts();

// });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    
     prod = Provider.of<Products>(context).products;

    var currentOrientation = Orientation.landscape;
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
      backgroundColor: Colors.black,
      appBar: _appBar,
      //bottomNavigationBar: bottomBar,
      
      body: FutureBuilder(
        future: Provider.of<Products>(context,listen: false).fetchAndSetProducts(),
        builder: (context,snapShot) {
          // if(snapShot.connectionState==ConnectionState.waiting){

          //   return Center(child: CircularProgressIndicator());
          // }
          
          
          return Center(
            heightFactor: 1,
            child: Container(
              width: currentOrientation == Orientation.landscape
                  ? 550
                  : double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: currentOrientation == Orientation.landscape
                          ? height * 70
                          : height * 78,
                      child: ListView.builder(
                        itemCount: prod.length,
                        itemBuilder: (ctx, index) => GestureDetector(
                         onTap: (){
                           Navigator.of(context).pushNamed(VariationsScreen.routeName,arguments: prod[index].id);
                         },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 17,
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
                                    vertical: 19,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(prod[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                              SizedBox(height: 20,),
                                              Text('Delivery Date',style: Theme.of(context).textTheme.bodyText2,),
                                              SizedBox(height: 1.5,),
                                      Text(prod[index].deliveryDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!),
                                      SizedBox(height: 25,),
                                      Text(
                                        'Starting \$${prod[index].price}/week',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                ), //ContentConatiner
                                Center(
                                  child: Container(
                                    width: 120,
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    margin: EdgeInsets.only(right: 15),
                                    child: Image.network(prod[index].imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                ), //imageContainer
                              ],
                            ),
                          ),
                        ),
                      ),
                    ), //Listview end
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
