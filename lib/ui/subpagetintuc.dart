import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';

class SubPageTintuc extends StatelessWidget {
  const SubPageTintuc({super.key});

  static int idpage  = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Color.fromARGB(255, 93, 62, 83)
      , child: Center(child: Text("Tin tức"),)),
    );
  }
}
