import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gofit/constants/theme.dart';
import 'package:gofit/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:gofit/screens/auth_ui/login/login.dart';
import 'package:gofit/screens/auth_ui/welcome/welcome.dart';
import 'package:gofit/screens/home/home.dart';

import 'screens/custom_bottom_bar/custom_bottom_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      title: "GoFit",
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot) {
          // if (snapshot.hasData) {
          //   // print(snapshot.toString());
          //   return const CustomBottomBar();
          // }
          return const Welcome();
        },
      ),
    );
  }
}
