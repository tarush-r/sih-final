// import 'package:firebase/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sih_final/screens/splash_screen.dart';

class ApproveChildrenProvider with ChangeNotifier {
  List approveItem = [];
  List rescueItem = [];

  bool isLoading = true;

  void initData() async {
    isLoading = true;
    notifyListeners();
    QuerySnapshot approvedChildrenDocs = await complaintDetailsRef.where('is_approved', isEqualTo: false).get();
    print("Printing docs");
    approveItem = [];
    print(approvedChildrenDocs.docs);

    isLoading = false;
    notifyListeners();
  }
}
