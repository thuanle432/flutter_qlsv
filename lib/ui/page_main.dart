import 'package:avatar_glow/avatar_glow.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/ui/AppContant.dart';
import 'package:connection/ui/page_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';
import 'page_dangkylop.dart';
import 'subpagediemdanh.dart';
import 'subpagedshocphan.dart';
import 'subpagedslop.dart';
import 'subpageprofile.dart';
import 'subpagetimkiem.dart';
import 'subpagetintuc.dart';

class PageMain extends StatelessWidget {
  static String routername = '/';
  PageMain({super.key});
  final List<String> menuTitles = ["Tin tức","Profile", "Điểm danh", "Tìm kiếm", "Ds lớp", "Ds học phần"];
  final menuBar = MenuItemlist();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewmodel = Provider.of<MainViewModel>(context);
    Profile profile = Profile();
    if(profile.token == ""){
      return PageLogin();
    }


    if(profile.student.mssv == ""){
      return PageDangkyLop();
    }
    Widget body = SubPageTintuc();


    if(viewmodel.activemenu == SubPageProfile.idpage){
      body = SubPageProfile();
    }else if(viewmodel.activemenu == SubPageProfile.idpage){
      body = SubPageProfile();
    }else if(viewmodel.activemenu == SubPageDiemdanh.idpage){
      body = SubPageDiemdanh();
    }else if(viewmodel.activemenu == SubPageTimkiem.idpage){
      body = SubPageTimkiem();
    }else if(viewmodel.activemenu == SubPageDslop.idpage){
      body = SubPageDslop();
    }else if(viewmodel.activemenu == SubPageDshocphan.idpage){
      body = SubPageDshocphan();
    }


    menuBar.initialize(menuTitles);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        leading: GestureDetector(
          onTap: () => viewmodel.ToggleMenu(),
          child: const Icon(Icons.menu,
          color: Colors.white,
          ),
        ),
      ),
      
      body: Stack(
        children: [
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return  GestureDetector(
                onTap: () => viewmodel.closeMenu(),
                child: Container(
                  color: Colors.deepPurple[300],
                  child:  Center(
                    child: body,
                  ),
                ),
              );
            },
            
          ),
          viewmodel.menustatus == 1?
          Consumer<MenuBarViewModel>(
            builder: (context, menuBarModel, child) {
              return GestureDetector(
              onPanUpdate: (details) {
                menuBarModel.setOffset(details.localPosition);
              },
              onPanEnd: (details) {
                menuBarModel.setOffset(Offset(0, 0));
                viewmodel.closeMenu();
              },
              child: Stack(
                children: [
                  Custom_menubar(size: size),
                  menuBar
                ],
              )
              );
            },
            
          )
          :Container(),
        ],
      ),
    );
  }
}


class MenuItemlist extends StatelessWidget {
  MenuItemlist({
    super.key,
  });


  final List<MenuBarItem> menuBarItems =[];
  void initialize(List<String> menuTitles){
    menuBarItems.clear();
    for(int i= 0; i< menuTitles.length; i++){
      menuBarItems.add(MenuBarItem(
        idpage: i,
         containerkey: GlobalKey(),
          title: menuTitles[i]));
    }
  }
  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * 0.20,
          width: size.width * 0.65,
          child: Center(
            child: AvatarGlow(
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              endRadius: size.height * 0.2,
              glowColor: Colors.black38,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(size.height),
                child: SizedBox(
                  height: size.height * 0.16,
                  width: size.height * 0.16,
                  child: const Image(
                    image: AssetImage('assets/images/messi3.jpg'))),
              ),
            ),
          ),
        
        ),
        Container(height: 2, width: size.width * 0.65, color: Colors.deepPurple),
        SizedBox(
          height: size.height * 0.6,
          width: size.width * 0.65,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: menuBarItems.length,
              itemBuilder: (context , index){
                return menuBarItems[index];
              }),
          ),
        ),
      ],
    );
  }
}

class MenuBarItem extends StatelessWidget {
  MenuBarItem({
    super.key,
    required this.title, required this.containerkey, required this.idpage,
  });
  final int idpage;
  final String title;
  final GlobalKey containerkey;

  TextStyle style = AppContant.textbody;

  void onPanMove(Offset offset){
    if(offset.dy == 0){
      style = AppContant.textbody;
    }
    if(containerkey.currentContext != null){
      RenderBox box = containerkey.currentContext!.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);
      if(offset.dy < position.dy - 40 && offset.dy > position.dy - 80){
        style = AppContant.textbodyfocus;
        MainViewModel().activemenu = idpage;
      }else{
        style = AppContant.textbody;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final menuBarModel = Provider.of<MenuBarViewModel>(context);
    onPanMove(menuBarModel.offset);
    return GestureDetector(
      onTap: () => MainViewModel().setActiveMenu(idpage),
      child: Container(
        key: containerkey,
        alignment: Alignment.centerLeft,
        height: 40,
        child: Text(title, style: style,),
      ),
    );
  }
}

class Custom_menubar extends StatelessWidget {
  const Custom_menubar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final sizeBarModel = Provider.of<MenuBarViewModel>(context);

    final size = MediaQuery.of(context).size;
    return CustomPaint(
      size: Size(size.width * 0.65, size.height),
      painter: DrawesCustomPaint(offset: sizeBarModel.offset),
    );
  }
}
class DrawesCustomPaint extends CustomPainter{
  final Offset offset;

  DrawesCustomPaint({super.repaint, required this.offset});
  double generatePoitx(double width){
    double kq = 0;
    if(offset.dx == 0){
      kq = width;
    }
    else if(offset.dx < width){
      kq = width + 75;
    }else{
      kq = offset.dx;
    }
    return kq;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint paint = Paint() ..color = Colors.white .. style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    // path.lineTo(size.width, size.height);
    path.quadraticBezierTo(generatePoitx(size.width), offset.dy, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    // throw UnimplementedError();
    return true;
  }

}

