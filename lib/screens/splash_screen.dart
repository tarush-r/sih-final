import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sih_final/screens/choice_screen.dart';

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


final db = FirebaseFirestore.instance;
final testRef = db.collection('test');
final childDetailsRef = db.collection('childDetails');
final attendanceDetailsRef = db.collection('attendanceDetails');
final schoolDetailsRef = db.collection('schoolDetails');
final complaintDetailsRef = db.collection('complaintDetails');

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChoiceScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Icon(
        Icons.child_care,
        size: 100,
      )),
    );
  }
}
