import 'dart:io';

import 'package:connection/models/user.dart';
import 'package:connection/services/api_service.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class UserResponsitory {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiService().getUserInfo(); // đoạn này coi lại thử
    if(response != null){
      var json = response.data['data'];
      user = User.fromJson(json);
    }
    return user;
  }


   Future<bool> updateProfile() async {
    bool kq = false;
    var response = await ApiService().updateProfile();
    if(response != null){
      kq = true;

    }
    return kq;
  }
  Future<void> uploadAvatar(XFile image) async{
    ApiService api =  ApiService();
    if(image != null){

      final img.Image originalImage = 
      img.decodeImage(File(image.path).readAsBytesSync())!;
      final img.Image resizedImage = img.copyResize(originalImage, width: 300);

      final File resizedFile = 
        File(image.path.replaceAll('.jpg', '_resized.jpg'))
        ..writeAsBytesSync(img.encodeJpg(resizedImage));

        await api.uploadAvatarToServer(File(resizedFile.path));
    }
  }
}