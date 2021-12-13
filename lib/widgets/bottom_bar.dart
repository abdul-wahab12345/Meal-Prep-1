import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class BottomNavBar extends StatefulWidget {
  int index;
  Function onTap;
  Type type;
  BottomNavBar({required this.index, required this.onTap,this.type = Type.Default});

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
    switch (widget.type) {
      case Type.Reactive:
        items = [
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: "Plans",
          ),
        ];
        break;
      case Type.Pause:
        break;
      default:
        break;
    }

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
