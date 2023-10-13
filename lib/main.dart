import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dashboard.dart';
import 'pages/auth/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _localStorage =
      SharedPreferences.getInstance();

  bool isLoggedIn = false;

  void checkToken() async {
    SharedPreferences localStorage = await _localStorage;
    final token = localStorage.getString('token');

    print('Token: $token');

    token != null
        ? setState(() {
            isLoggedIn = true;
          })
        : setState(() {
            isLoggedIn = false;
          });
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Loyalty App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFB3284E),
        secondaryHeaderColor: const Color(0xFF493087),
        cardColor: Colors.yellow[900],
        fontFamily: 'Quicksand',
      ),
      home: isLoggedIn ? Dashboard() : const LoginPage(),
    );
  }
}
