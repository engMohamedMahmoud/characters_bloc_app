import 'package:bloc_first_app/helpers/colors/colors.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: MyColors.myYellow));
  }
}
