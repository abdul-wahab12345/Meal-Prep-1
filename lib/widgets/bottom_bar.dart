import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({ Key? key }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int navBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(38, 43, 55, 1),
          iconSize: 27,
          unselectedItemColor: Colors.white,
          selectedItemColor: Color.fromRGBO(142, 77, 255, 1),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining),
              label: "Delivery",
            ),
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
      );
  }
}