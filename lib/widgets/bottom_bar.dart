import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  int index;
  Function onTap;
  BottomNavBar({required this.index, required this.onTap});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.delivery_dining),
      label: "Delivery",
    ),
    BottomNavigationBarItem(icon: Icon(Icons.next_plan_sharp), label: "Plans"),
    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(38, 43, 55, 1),
        iconSize: 27,
        unselectedItemColor: Colors.white,
        selectedItemColor: Color.fromRGBO(142, 77, 255, 1),
        items: items,
        currentIndex: widget.index,
        onTap: (index) {
          setState(() {
            widget.index = index;
            widget.onTap(index);
          });
        },
      ),
    );
  }
}
