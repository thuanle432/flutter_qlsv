import 'package:flutter/material.dart';

class MainViewModel with ChangeNotifier{
  static final MainViewModel _instace = MainViewModel._internal();
  MainViewModel._internal();
  factory MainViewModel() {
    return _instace;
  }
  int menustatus = 0;
  int activemenu = 0;
  void ToggleMenu(){
    if(menustatus == 0){
      menustatus = 1;

    }else{
      menustatus = 0;
    }
    notifyListeners();
  }
  void closeMenu(){
    menustatus = 0;
    notifyListeners();
  }
  void setActiveMenu(int index){
    activemenu = index;
    menustatus = 0;
    notifyListeners();
  }
}