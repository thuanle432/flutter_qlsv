import 'package:connection/providers/loginviewmodel.dart';
import 'package:connection/services/api_service.dart';
import 'package:connection/ui/AppContant.dart';
import 'package:connection/ui/page_forgot.dart';
// import 'package:connection/ui/AppContant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_main.dart';
import 'package:connection/ui/page_register.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageLogin extends StatelessWidget {
  PageLogin({super.key});

  static String routername = '/login';

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future login(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    ApiService api= ApiService();
    Response? response = await  api.loginUser(username, password);
    if(response?.statusCode == 200){
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
         MaterialPageRoute(
          builder: (context) => PageMain()
        )
      );
    }
    
  }

 @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;
    if(viewmodel.status== 3){
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(context,MaterialPageRoute(builder: (context) => PageMain()));
          
        },
      );
    }
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bautroi.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Đăng nhập',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          controller:_usernameController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Colors.red)
                            ),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Tên người dùng",
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.person,
                              color: Colors.black,
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextField(
                          obscureText: true,
                          controller:_passwordController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Colors.red)
                            ),
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Mật khẩu",
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Icon(Icons.lock,
                              color: Colors.black,
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    viewmodel.status == 2? Text(viewmodel.errorMessage,
                    style: TextStyle(color: Colors.red),): Text(" "),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:45),
                      child: GestureDetector(
                        onTap: () {
                          String username = _usernameController.text.trim();
                          String password =  _passwordController.text.trim();
                          viewmodel.login(username, password);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                          ),
                          child: const Center(
                            child: Text("Đăng nhập",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            )
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Chưa có tài khoản? ", style: TextStyle(color: Colors.black),),
                        GestureDetector(
                            onTap: (){
                              Navigator.of(context).popAndPushNamed(PageRegister.routername);
                            },
                            child: const Text(" đăng ký",
                            style: TextStyle(color: Colors.red),
                            ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => PageForgot()));
                      },
                      child: Text("Quên mật khẩu", style: AppContant.textlink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            viewmodel.status == 1? CustomSpinner(size: size)
            : Container(),
          ],
        ),
      ),
    );
  }
}



