// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../global/global.dart';
import '../brandsScreens/home_screen.dart';
import '../splashScreen/my_splash_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/loading_dialog.dart';

class LoginTabPage extends StatefulWidget {
  const LoginTabPage({super.key});

  @override
  State<LoginTabPage> createState() => _LoginTabPageState();
}

class _LoginTabPageState extends State<LoginTabPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey formKey = GlobalKey<FormState>();

  validateForm() {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      // allow user to login
      loginNow();
    } else {
      Fluttertoast.showToast(msg: "Please enter email and password");
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (context) => LoadingDialog(
              message: "Checking credentials!!\n",
            ));

    User? currentUser;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred: \n $errorMessage");
    });

    if (currentUser != null) {
     checkIfSellerRecordExists(currentUser!); 
    }
  }

  checkIfSellerRecordExists(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if(record.exists){
       // status approved
       if(record.data()!["status"] == 'approved') {
        sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences!.setString("uid", record.data()!["uid"]);
        await sharedPreferences!.setString("name", record.data()!["name"]);
        await sharedPreferences!.setString("email", record.data()!["email"]);
        await sharedPreferences!.setString("photoUrl", record.data()!["photoUrl"]);

        //navigate to home screen
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));
       } else{
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "You have been Blocked by Admin.\n Please contact Admin: admin@ishop.com.",
            gravity: ToastGravity.CENTER,);
       }
      } else // status not approved
      {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: "This seller's record does not exit",
          gravity: ToastGravity.CENTER,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/seller.png',
              //width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.height * 0.40,
            ),
          ),
          Form(
              key: formKey,
              child: Column(children: [
                // email
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  icon: Icons.email,
                  hintText: 'Email',
                  isObscure: false,
                  enabled: true,
                ),
                // password
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  icon: Icons.lock,
                  hintText: 'Password',
                  isObscure: true,
                  enabled: true,
                ),

                // confirm password
                const SizedBox(
                  height: 20,
                ),
              ])),
          // register button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              validateForm();
            },
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
