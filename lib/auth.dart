import 'package:flutter/material.dart';
import 'package:loginpage/login_page.dart';
import 'package:loginpage/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;
  void togglescreens() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(showRegisterPage: togglescreens);
    } else {
      return RegisterPage(showLoginPage: togglescreens);
    }
  }
}
