import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/widgets/input_feild.dart';

class TasteTab extends StatelessWidget {
  TasteTab({Key? key}) : super(key: key);

  var _Alergcontroller = TextEditingController();
  var _disLikeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TasteContainer(
          controller: _Alergcontroller,
          title: '⛔ Allergens',
        ),
        SizedBox(
          height: 18,
        ),
        TasteContainer(
          controller: _disLikeController,
          title: '🤢 Dislikes',
        ),
      ],
    ));
  }
}

class TasteContainer extends StatefulWidget {
  TasteContainer({
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;

  String title;

  @override
  State<TasteContainer> createState() => _TasteContainerState();
}

class _TasteContainerState extends State<TasteContainer> {
  List<String> labels = [];

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    return Container(
      padding: EdgeInsets.all(30),
      height: currentOrientation == Orientation.landscape
          ? height * 60
          : height * 23,
      width:
          currentOrientation == Orientation.landscape ? width * 50 : width * 80,
      decoration: BoxDecoration(
        color: aPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.title,
                style: TextStyle(
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 25,
                ),
              ),
            ), //titleContainer
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextField(
                controller: widget.controller,
                onSubmitted: (v) {
                  setState(() {
                    labels.add(v);
                    widget.controller.clear();
                    print(labels);
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            //Row(children: [...labels.map((e) => Chip(label: Text(e),),),],)
            Container(
              height: 50,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: labels.length,
                  itemBuilder: (ctx, index) => Chip(
                        label: Text(
                          labels[index],
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }
}
