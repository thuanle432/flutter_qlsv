
import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';

class SubPageTimkiem extends StatelessWidget {
  const SubPageTimkiem({super.key});
  static int idpage  = 3;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Color.fromARGB(255, 93, 62, 83)
      , child: Center(child: Text("Timkiem"),)),
    );
  }
}
