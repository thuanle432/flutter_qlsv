import 'package:connection/models/profile.dart';
import 'package:connection/providers/diachimodel.dart';
import 'package:connection/providers/forgotviewmodel.dart';
import 'package:connection/providers/loginviewmodel.dart';
import 'package:connection/providers/mainviewmodel.dart';
import 'package:connection/providers/menubarviewmodel.dart';
import 'package:connection/providers/profileviewmodel.dart';
import 'package:connection/providers/registerview_model.dart';
import 'package:connection/services/api_service.dart';
import 'package:connection/ui/page_forgot.dart';
import 'package:connection/ui/page_login.dart';
import 'package:connection/ui/page_main.dart';
import 'package:connection/ui/page_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ApiService api = ApiService();
  api.initialize();
  Profile profile = Profile();
  profile.initialize();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<LoginViewModel>(create: (context) => LoginViewModel(),
      ),
      ChangeNotifierProvider<RegisterViewModel>(create: (context) => RegisterViewModel(),
      ),
      ChangeNotifierProvider<ForgotViewModel>(create: (context) => ForgotViewModel(),
      ),
      ChangeNotifierProvider<MainViewModel>(create: (context) => MainViewModel(),
      ),
      ChangeNotifierProvider<MenuBarViewModel>(create: (context) => MenuBarViewModel(),
      ),
      ChangeNotifierProvider<ProfileViewModel>(create: (context) => ProfileViewModel(),
      ),
      ChangeNotifierProvider<DiaChiModel>(create: (context) => DiaChiModel(),
      ),
    ], child:  const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home':(context) => PageMain(),
        '/login':(context) =>  PageLogin(),
        '/register':(context) => PageRegister(),
        '/forgotr':(context) => PageForgot(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageLogin()
    );
  }
}




