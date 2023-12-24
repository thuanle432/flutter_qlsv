import 'package:connection/responsitoris/register_responsitory.dart';
import 'package:flutter/widgets.dart';

class RegisterViewModel with ChangeNotifier{
  // 0: Chăng đăng ký
  //1: Đang đăng ký
  // 2: đăng ký lỗi
  //3 Đăng ký cần xác minh email

  int status = 0;
  String errormessage = "";
  bool agree = false;
  final registerRepo = RegisterRepository();
  String quydinh = "Khi bạn tham gia vào các ứng dụng các bạn đồng ý với các điều khoản sau:\n"
  + "1.Các thông tin của bạn sẽ được chia sẻ với các thành viênh học \n"
  + "2.Thông tin của bạn sẽ ảnh hưởng tới học tập của trường \n"
  + "3. Thông tin của bạn sẽ đước xoá vĩnh viễn ở trường";
  void setAgree(bool value){
    agree = value;
    notifyListeners();
  }
  Future<void> register(String email, String username, String pass1, String pass2) async {
    status = 1;
    notifyListeners();
    errormessage = "";
    if(agree == false){
      status = 2;
      errormessage += "Bạn phải đăng ký với đièu khoản trước đăng ký\n";
    }
    if(email.isEmpty || username.isEmpty || pass1.isEmpty){
      status = 2;
      errormessage += "Email, username, password không được đẻ trống\n";
    }
    final bool emailValid = RegExp(
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$").hasMatch(email);
    if(emailValid == false){
      status = 2;
      errormessage += "Email không hợp lệ";
    }
    if(pass1.length < 8){
      status = 2;
      errormessage += "Password cần lớn hơn 8 chữ \n";
    }
    if(pass1 != pass2){
      status = 2;
      errormessage += "Mật khẩu không giống nhau";
    }
    if(status != 2 ){
      status = await registerRepo.register(email,username,pass1);
    }
    
    ///Sử dụng responsitory gọi hàm login lấy kết quả
    notifyListeners();
  }
  
}