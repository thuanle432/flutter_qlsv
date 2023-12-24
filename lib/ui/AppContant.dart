

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class AppContant{
  static TextStyle textfancyheader = GoogleFonts.flavors(
    fontSize: 40,
    color: Colors.white
  );
  static TextStyle texterror =const TextStyle(
    color: Colors.red,
    fontSize: 15,
    fontStyle: FontStyle.italic
  );
  static TextStyle textlink = TextStyle(
    color: Colors.purple[300],
    fontSize: 16
  );
  static TextStyle textbody = TextStyle(
    color: Colors.purple[300],
    fontSize: 16
  );
  static TextStyle textbodyfocus = const TextStyle(
    color: Colors.purple,
    fontSize: 20
  );
  static TextStyle backgroundcolor = const TextStyle(
    color: Color.fromARGB(255, 113, 88, 111),
  );
  static bool isDate(String str){
    try{
      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parseStrict(str);
      
      return true;
    }
    catch(e){
      return false;
    }
  }
}