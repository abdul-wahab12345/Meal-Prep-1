import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class MaintainanceScreen extends StatelessWidget {
  const MaintainanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: abackground,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'We are improving your Experience',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 19,
                    fontFamily: 'IBM'
                  ),
                ),
              
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:58.0),
                child: Image.asset('assets/images/update.png'),
              ),
              Center(
                child: Text(
                  'Just 1 Day Remaining.',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 14,
                     fontFamily: 'IBM'
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
