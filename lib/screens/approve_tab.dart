import 'package:flutter/material.dart';
import 'package:sih_final/screens/splash_screen.dart';
import 'package:sih_final/widgets/approve_item.dart';

class ApproveTab extends StatefulWidget {
  @override
  State<ApproveTab> createState() => _ApproveTabState();
}

class _ApproveTabState extends State<ApproveTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: complaintDetailsRef
          .where('is_approved', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        print('printing snapshot');
        print(snapshot.data.docs);
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context2, index) {
            return ApproveItem(
              childName: snapshot.data.docs[index]['child_name'],
              imageUrl: snapshot.data.docs[index]['image'],
              isApproved: snapshot.data.docs[index]['is_approved'],
              docId: snapshot.data.docs[index].id,
            );
          },
        );
      },
    );
  }
}
