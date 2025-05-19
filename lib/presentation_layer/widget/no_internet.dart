import 'package:bloc_first_app/helpers/colors/colors.dart';
import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text(
              'Can\'t connect .. check internet',
              style: TextStyle(fontSize: 22, color: MyColors.myGrey),
            ),
            Image.asset('assets/images/no_internet.png'),
          ],
        ),
      ),
    );
  }
}
