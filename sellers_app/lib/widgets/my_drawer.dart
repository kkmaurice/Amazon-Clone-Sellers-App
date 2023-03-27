import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/ordersScreen/orders_screen.dart';

import '../splashScreen/my_splash_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(children: [
        //header
        Container(
          padding: const EdgeInsets.only(top: 26.0, bottom: 12.0),
          child: Column(children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage:
                  NetworkImage(sharedPreferences!.getString('photoUrl')!),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              sharedPreferences!.getString('name')!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sharedPreferences!.getString('email')!,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w100,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
          ]),
        ),
        //body
        Container(
          padding: const EdgeInsets.only(top: 1.0),
          child: Column(
            children: [
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
                // endIndent: 32.0,
              ),

              //home
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MySplashScreen()));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
              ),
              // my orders
              ListTile(
                leading: const Icon(
                  Icons.reorder,
                  color: Colors.grey,
                ),
                title: const Text(
                  'New Orders',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OrdersScreen()));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
              ),
              // not yet received orders
              ListTile(
                leading: const Icon(
                  Icons.picture_in_picture_alt_rounded,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Not Yet Received Orders',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
              ),
              // history
              ListTile(
                leading: const Icon(
                  Icons.access_time,
                  color: Colors.grey,
                ),
                title: const Text(
                  'History',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
              ),
              // search
              ListTile(
                leading: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {},
              ),
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
              ),
              // logout
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.grey,
                ),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MySplashScreen(),
                      ));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.grey,
                height: 10.0,
                thickness: 2,
                indent: 15.0,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
