
import 'package:connection/models/student.dart';
import 'package:connection/responsitoris/login_responsitory.dart';
import 'package:connection/responsitoris/student_responsitory.dart';
import 'package:connection/responsitoris/user_responsitory.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class LoginViewModel with ChangeNotifier{
  String errorMessage = "";
  int status = 0;
  LoginResponsitory loginRepo = LoginResponsitory();
  Future<void> login(String username, String password) async {
    status = 1;
    notifyListeners();
    try {
      var profile = await loginRepo.login(username, password);
        if(profile.token == ""){
          status = 2;
          errorMessage = "Tên đăng nhập hoặc mật khẩu sai!";
        }else{
          status = 3;
          //đăng nhập thành công, lấy thông tin user
          var student = await StudentResponsitory().getStudentInfo(); // đoạn này đang lỗi
          profile.student = Student.fromStudent(student);
          var user  = await UserResponsitory().getUserInfo();
          profile.user = User.fromUser(user);
        
        }
        notifyListeners();
    }
    catch(e){}
    
  }
}