import 'package:connection/models/profile.dart';
import 'package:connection/responsitoris/lophoc_reponsitory.dart';
import 'package:connection/responsitoris/student_responsitory.dart';
import 'package:connection/responsitoris/user_responsitory.dart';
import 'package:connection/ui/AppContant.dart';
import 'package:connection/ui/page_main.dart';
import 'package:flutter/material.dart';

import '../models/lop.dart';
import 'custom_control.dart';

class PageDangkyLop extends StatefulWidget {
  const PageDangkyLop({super.key});
  

  @override
  State<PageDangkyLop> createState() => _PageDangkyLopState();
}

class _PageDangkyLopState extends State<PageDangkyLop> {
  List<Lop>? listlop = [];
  Profile profile = Profile();
  String mssv = '';
  String ten = '';
  int idlop = 0;
  String tenlop = '';
  @override
  void initState() {
    // TODO: implement initState

    mssv = profile.student.mssv;
    ten = profile.user.first_name;
    idlop = profile.student.idlop;
    tenlop =  profile.student.tenlop;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
 

      
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text('Thêm thông tin cơ bản', 
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.deepPurple,
                    ) 
                  ),
                  const Text('Không thể quay lại trang chủ sau khi rời đi. Vì vậy hãy kiểm tra kỹ nhé',
                    style: TextStyle(
                      color: Colors.red
                    )
                  ),
                  const SizedBox(height: 20,),
                  CustomTextInputFormField(
                    title: "Tên",
                    value: ten, 
                    width: size.width,
                    callback: ((output) {
                      ten = output;
                    }),
                  ),
                  CustomTextInputFormField(
                    title: "MSSV",
                    value: mssv, 
                    width: size.width,
                    callback: ((output) {
                      mssv = output;
                    }),
                  ),
                  listlop!.isEmpty?
                  FutureBuilder(
                    future: LopResponsitory().getDsLop(),
                    builder: (context, AsyncSnapshot<List<Lop>> snapshort ) {
                      if(snapshort.connectionState == ConnectionState.waiting){
                        return const CircularProgressIndicator();
                      }else if(snapshort.hasData){
                        listlop = snapshort.data;
                        return CustomTextInputDropDown(
                          width: size.width,
                          list: listlop!,title: "Lớp",
                          valueid: idlop,valuename: tenlop,
                          callback: (outputid, outputname) {
                          idlop= outputid;
                          tenlop  = outputname;
                        },);
                      }else{
                        return Text("Lỗi xảy ra");
                      }
                    }
                  ): CustomTextInputDropDown(
                      width: size.width,
                      list: listlop!,
                      title: "Lớp",
                      valueid: idlop,valuename: tenlop,
                      callback: (outputid, outputname) {
                        idlop= outputid;
                        tenlop  = outputname;
                      },
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                      ),
                      child:  Center(
                      child: GestureDetector(
                        onTap: () async {
                          profile.student.mssv = mssv;
                          profile.student.idlop = idlop;
                          profile.student.tenlop = tenlop;
                          profile.user.first_name = ten;
                          await UserResponsitory().updateProfile();
                          await StudentResponsitory().dangkyLop();
                        },
                        child: const Text("Lưu thông tin",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                      )
                      ),
                    ),
                    SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, PageMain.routername);
                      },
                      child: Text("Bấm vào đây để tới trang chủ", style: AppContant.textlink,)) 
                     

                    
                ],
                
              ),
            )
          ),
        ),
      ),
    );
  }
}

