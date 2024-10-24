//Auth Page -to show login or reg

import 'package:flutter/material.dart';
import 'package:socialmedia/pages/login_page.dart';
import 'package:socialmedia/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<AuthPage> {
  //initially show login page

  bool showLoginPage = true;

  //toggle between login or register page

  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    } else {
      return RegisterPage(onTap: togglePage);
    }
  }
}
