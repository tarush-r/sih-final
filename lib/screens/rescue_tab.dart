import 'package:flutter/material.dart';
import 'package:sih_final/screens/splash_screen.dart';
import 'package:sih_final/widgets/approve_item.dart';

import '../widgets/rescue_item.dart';

class RescueTab extends StatefulWidget {
  @override
  State<RescueTab> createState() => _RescueTabState();
}

class _RescueTabState extends State<RescueTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: complaintDetailsRef
          .where('is_approved', isEqualTo: true)
          .where('is_rescued', isEqualTo: false)
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
            return RescueItem(
              childName: snapshot.data.docs[index]['child_name'],
              imageUrl: snapshot.data.docs[index]['image'],
              isApproved: snapshot.data.docs[index]['is_approved'],
              childId: snapshot.data.docs[index]['child_id'],
              docId: snapshot.data.docs[index].id,
            );
          },
        );
      },
    );
  }
}


