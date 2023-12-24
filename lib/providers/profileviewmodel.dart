import 'package:connection/models/profile.dart';
import 'package:connection/responsitoris/user_responsitory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';

class ProfileViewModel with ChangeNotifier{
  int status = 0;
  int modified = 0;
  int updatedavatar = 0;


  void updatescreen(){
    notifyListeners();
  }
  void displaySpiner(){
    status = 1;
    notifyListeners();
  }
  void hideSpiner(){
    status = 0;
    notifyListeners();
  }
  void setModified(){
    if(modified == 0){

      modified = 1;
      notifyListeners();
    }
  }
  Future<void> updatProflie() async{
    status = 1;
    notifyListeners();
    await UserResponsitory().updateProfile();
    status = 0;
    modified = 0;
    notifyListeners();
  }
  void setUpdateavatar() {
    updatedavatar = 1;
    notifyListeners();
  }
  Future<void> uploadAvatar(XFile image) async{
    status = 1;
    notifyListeners();
    await UserResponsitory().uploadAvatar(image);
    var user = await UserResponsitory().getUserInfo();
    Profile().user = User.fromUser(user);
    updatedavatar = 0;
    status = 0;
    notifyListeners();
  }
}