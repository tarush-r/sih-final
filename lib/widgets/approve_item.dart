import 'package:flutter/material.dart';
import 'package:sih_final/screens/splash_screen.dart';

class ApproveItem extends StatelessWidget {
  final String childName;
  final bool isApproved;
  final String imageUrl;
  final String docId;

  ApproveItem({this.childName, this.isApproved, this.imageUrl, this.docId});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(childName),
          Expanded(child: Container()),
          GestureDetector(
            onTap:  () {
              complaintDetailsRef.doc(docId).update({
                'is_approved': true,
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                    'Approve',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap:  () {
              complaintDetailsRef.doc(docId).delete();
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                    'Reject',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
