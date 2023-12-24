import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/ui/AppContant.dart';
import 'package:connection/ui/custom_control.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageForgot extends StatelessWidget {
  PageForgot({super.key});
  static String routername = '/forgot';
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ForgotViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child:
            viewmodel.status == 3
            ? Column(
              children: [
                const Image(image: AssetImage('assets/images/tick.gif')),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Gửi yêu cầu tái tạo mật khẩu thành công,Truy cập vào email và làm theo hướng dẫn",
                    style: TextStyle(color: Colors.purple,
                    fontSize: 15),
                  ),
                ),
                
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
                  image: AssetImage("assets/images/vutru.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Ở đây lấy lại mật khẩu',
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
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
                                prefixIcon: Icon(Icons.email_outlined,
                                  color: Colors.black,
                                )
                              ),
                            ),
                          ),
                        ),
                       
                        const SizedBox(
                          height: 20,
                        ),
                        Text(viewmodel.errormessage , style: AppContant.texterror,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:45),
                          child: GestureDetector(
                            onTap: () {
                              final email = _emailController.text.trim();
                              viewmodel.forgotPassword(email);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                              ),
                              child: const Center(
                                child: Text("Gửi yêu cầu",
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
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context, MaterialPageRoute(
                                builder: (context) => PageLogin()));
                          },
                          child: const Text("Quay lại trang chủ",
                          style: TextStyle(color: Colors.purple),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            viewmodel.status == 1? CustomSpinner(size: size):Container()
            
          ],
        ),
      ),
    );
    
  }
}