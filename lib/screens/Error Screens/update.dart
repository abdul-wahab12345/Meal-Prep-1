import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({Key? key}) : super(key: key);

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
                  'We have Improved your Experience',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 19, fontFamily: 'IBM'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 58.0),
                child: Image.asset('assets/images/update1.png'),
              ),
              SizedBox(height: 50,),
              Center(
                child: Text(
                  'Try Downloading the latest version from the link below',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14, fontFamily: 'IBM'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/appstore.png',height: 100,width: 180,),
                    Image.asset('assets/images/google.png',height: 100,width: 180,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
