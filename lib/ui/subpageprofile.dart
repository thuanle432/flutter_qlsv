
import 'dart:io';

import 'package:connection/models/profile.dart';
import 'package:connection/providers/diachimodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:connection/ui/AppContant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/mainviewmodel.dart';
import 'custom_control.dart';

class SubPageProfile extends StatelessWidget {
  SubPageProfile({super.key});
  static int idpage  = 1;
  XFile? image;
  Future<void> init(DiaChiModel diachimodel ,ProfileViewModel viewmodel) async{
    Profile profile = Profile();
    
    if(diachimodel.listCity.isEmpty ||
     diachimodel.curCityId != profile.user.provinceid
    || diachimodel.curDistId != profile.user.districtid 
    || diachimodel.curWardId != profile.user.wardid){
      viewmodel.displaySpiner();
      await diachimodel.initialize(profile.user.provinceid, profile.user.districtid, profile.user.wardid);
      viewmodel.hideSpiner();
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<ProfileViewModel>(context);
    final diachimodel = Provider.of<DiaChiModel>(context);
    final size = MediaQuery.of(context).size;
    final profile = Profile();
    Future.delayed(Duration.zero,() => init(diachimodel, viewmodel));
    return GestureDetector(
      onTap: () => MainViewModel().closeMenu(),
      child: Container(
        color: Colors.white
      , child: Stack(
        children: [
          Column(
              children: [
                create_header(size, profile, viewmodel),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                  CustomTextInputFormField(
                                    title: "Điện thoại",
                                    value: profile.user.phone,
                                    width: size.width * 0.45, 
                                    callback:(output) {
                                      profile.user.phone = output;
                                      viewmodel.setModified();
                                      viewmodel.updatescreen();
                                    },
                                    type: TextInputType.phone,
                                  ),
                                  CustomTextInputFormField(
                                    title: "Ngày sinh",
                                    value: profile.user.birthday,
                                    width: size.width * 0.45, 
                                    callback:(output) {
                                      if(AppContant.isDate(output)){
                                        profile.user.birthday = output;
                                      }
                                      viewmodel.setModified();
                                      viewmodel.updatescreen();
                                    },
                                    type: TextInputType.datetime,
                                  ),    
                            ],  
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPlaceDropDown(
                                width: size.width * 0.45, 
                                title: "Thành phố/tỉnh", 
                                valueid: profile.user.provinceid, 
                                valueName: profile.user.provincename,
                                callback: (outputId, outputName) async {
                                  viewmodel.displaySpiner();
                                  profile.user.provinceid =  outputId;
                                  profile.user.provincename = outputName;
                                  await diachimodel.setCity(outputId);
                                  profile.user.districtid = 0;
                                  profile.user.wardid = 0;
                                  profile.user.districtname = "";
                                  profile.user.wardname = "";
                                  viewmodel.setModified();
                                  viewmodel.hideSpiner();
                                }, 
                                list: diachimodel.listCity, 
                                
                              ),
                              CustomPlaceDropDown(
                                width: size.width * 0.45, 
                                title: "Quận/huyện", 
                                valueid: profile.user.districtid, 
                                valueName: profile.user.districtname,
                                callback: (outputId, outputName) async {
                                  viewmodel.displaySpiner();
                                  profile.user.districtid =  outputId;
                                  profile.user.districtname = outputName;
                                  await diachimodel.setDistrict(outputId);
                                  profile.user.wardid = 0;
                                  viewmodel.setModified();
                                  viewmodel.hideSpiner();
                                }, 
                                list: diachimodel.listDistrict, 
                                
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomPlaceDropDown(
                                width: size.width * 0.45, 
                                title: "Phường/xã", 
                                valueid: profile.user.wardid, 
                                valueName: profile.user.wardname,
                                callback: (outputId, outputName) async {
                                  viewmodel.displaySpiner();
                                  profile.user.wardid =  outputId;
                                  profile.user.wardname = outputName;
                                  await diachimodel.setWard(outputId);
                                  viewmodel.setModified();
                                  viewmodel.hideSpiner();
                                }, 
                                list: diachimodel.listWard, 
                                
                              ),
                              CustomTextInputFormField(title: "Số nhà",value: profile.user.address,width: size.width * 0.45, callback:(output) {
                                     profile.user.address = output;
                                     viewmodel.setModified();
                                     viewmodel.updatescreen();
                                  },type: TextInputType.streetAddress,),
                              
                            ],
                          ),
                          
                          const SizedBox(height: 10,),
                          SizedBox(
                            height: size.width * 0.3,
                            width: size.width * 0.3,
                            child: QrImageView(data: '{userid: '+profile.user.id.toString()+ '}', version: QrVersions.auto, gapless: false,))
                        ],
                      ),
                    ),
                   
                  ),
                )
              ],),
              viewmodel.status == 1?CustomSpinner(size: size): Container(),
        ],
      )
      ),
    );
  }

  Container create_header(Size size, Profile profile, ProfileViewModel viewmodel) {
    // XFile? image;
    return Container(
            height: size.height* 0.25,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 115, 211, 226),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
              
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star ,color: Colors.yellow,),
                        Text(profile.student.diem.toString())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: viewmodel.updatedavatar == 1 && image != null ?
                      Stack(

                        children: [
                          ClipRRect(
                            borderRadius:BorderRadius.circular(100),
                            child: SizedBox(
                              width: 100,
                              height: 100, 
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.fill,
                                
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                viewmodel.uploadAvatar(image!);
                              },
                              child: Container(
                                color: Colors.white,
                                child: const Center(
                                  child:
                                  Icon(Icons.save, size: 30,)),
                              ),
                            ),
                          )
                        ],
                      )
                      :GestureDetector(
                        onTap: () async{
                          final ImagePicker _picker = ImagePicker();
                          image = await _picker.pickImage(source: ImageSource.gallery);
                          viewmodel.setUpdateavatar();
                        },
                        child: Customavatar1(size: size)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     const Text('Tên: ',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                    Text(profile.user.first_name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),),
                    Row(
                      children: [
                        const Text('MSSV: ',
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(profile.student.mssv,
                        style: const TextStyle(
                          color: Colors.white
                        ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Lớp: ", 
                        style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(profile.student.tenlop,
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                        profile.student.duyet == 0? const Text("( Chưa duyệt ) ",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ): const Text(""),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Vai trò: ", 
                        style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        
                        profile.user.role_id == 4? const Text("Sinh viên",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ): const Text("Giảng viên"),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: viewmodel.modified == 1? 
                        GestureDetector(
                          onTap: (){
                            viewmodel.updatProflie();
                          },
                          child: Icon(Icons.save)): Container(),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}

