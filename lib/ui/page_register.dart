import 'package:connection/models/profile.dart';
import 'package:connection/providers/registerview_model.dart';
import 'package:connection/ui/AppContant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PageRegister extends StatelessWidget {
  PageRegister({super.key});


  static String routername = '/register';
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  bool agree = true;

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<RegisterViewModel>(context);
    final size  = MediaQuery.of(context).size;
    final profile = Profile();
    if(profile.token != ""){ ///Kiểm tra đã đăng nhập chưa
      Future.delayed(
        Duration.zero,
        () {
          Navigator.pop(context);
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => PageMain(),
            )
          );
        },
      );
    }


    return Scaffold(
      body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child:
            viewmodel.status == 3 || viewmodel.status == 4
            ? Column(
              children: [
                const Image(image: AssetImage('assets/images/tick.gif')),
                Text("Đăng ký thành công",
                style: AppContant.textfancyheader,),
                viewmodel.status == 3?
                  const Text("bạn cần xác nhận email trước khi đăng ký")
                  : const Text(""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => PageLogin()));
                      },
                      child: Text("Bấm vào đây", style: AppContant.textlink,
                      ),
                    ),
                    const Text(" để đăng nhập"),
                  ],
                )
              ],
            )
            
            : Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/bautroi.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Center(
                    child:
                    
                     SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    
                          Text('Đăng ký',
                            style: AppContant.textfancyheader,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,color: Colors.red)
                                  ),
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.black),
                                  prefixIcon: Icon(Icons.mail_outlined,
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
                                controller: _usernameController,
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
                                controller: _password1Controller,
                                obscureText: true,
                      
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: TextField(
                                controller: _password2Controller,
                                obscureText: true,
                      
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1,color: Colors.red)
                                  ),
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Nhập lại mật khẩu",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: viewmodel.agree, 
                                onChanged: (value) {
                                  viewmodel.setAgree(value!);
                                }
                              ),
                              const Text("Đồng ý ",
                              style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context, 
                                    builder: (context) => AlertDialog(
                                      title: const Text("Quy định"),
                                      content: SingleChildScrollView(
                                        child: Text(viewmodel.quydinh)),
                                    )
                                  );
                                },
                                child: Text("quy định",
                                style: AppContant.textlink),
                              )
                            ],
                          ),
                          Text(
                            viewmodel.errormessage, 
                            style: AppContant.texterror,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal:45),
                            child: GestureDetector(
                              onTap: (){
                                final email = _emailController.text.trim();
                                final username = _usernameController.text.trim();
                                final pass1 = _password1Controller.text.trim();
                                final pass2 = _password2Controller.text.trim();
                                viewmodel.register(email, username, pass1, pass2);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                ),
                                child: const Center(
                                  child: Text("Đăng ký",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                  )
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => PageLogin()));
                            },
                            child: Text("Nhấn vào đây để đăng nhập",
                            style: AppContant.textlink,
                            ),
                          )
                    
                        ],
                      ),
                    ),
                  ),
                ),
                viewmodel.status == 1
                ? CustomSpinner(size : size)
                : Container(),
              
              ],
            ),
          ),
       
      ),
    );
  }
}