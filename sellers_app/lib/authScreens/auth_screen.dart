import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'login_tab_page.dart';
import 'registration_tab_page.dart';


class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          )
          ),
          title: const Text(
            'iShop',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              letterSpacing: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true, 
          elevation: 0.0,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            tabs: [
              Tab(
                icon: Icon(Icons.lock),
                text: 'Login',
              ),
              Tab(
                icon: Icon(Icons.person_add),
                text: 'Register',
              ),
            ],
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: const TabBarView(
            children: [
              LoginTabPage(),
              RegistrationTabPage()
            ]
            ),
          ),
      )
      );
  }
}