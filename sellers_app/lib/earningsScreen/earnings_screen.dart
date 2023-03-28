import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/splashScreen/my_splash_screen.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String totalEarnings = '';

  readTotalEarnings() async {
    await FirebaseFirestore.instance
        .collection('sellers')
        .doc(sharedPreferences!.getString('uid'))
        .get()
        .then((snap) {
      setState(() {
        totalEarnings = snap.data()!['earning'].toString();
      });
    });
  }

  @override
  void initState() {
    readTotalEarnings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              '\$ $totalEarnings',
              style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Total Earnings',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
                thickness: 1.5,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Card(
              color: Colors.white54,
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 140),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const MySplashScreen()));
                },
                leading: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                title: const Text(
                  'Go Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
