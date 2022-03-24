import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sih_final/models/child_detail_model.dart';
// import 'package:sih_2022/screens/studentList.dart';
import 'package:sih_final/screens/splash_screen.dart';
import 'package:sih_final/screens/student_attendance.dart';
import 'package:sih_final/screens/student_list.dart';

class AttendanceStudentsList extends StatefulWidget {
  // const DpsAttendance({ Key? key }) : super(key: key);

  @override
  State<AttendanceStudentsList> createState() => _DpsAttendanceState();
}

class _DpsAttendanceState extends State<AttendanceStudentsList> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            }),
        title: Text('Student List'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [Padding(padding: EdgeInsets.all(8))],

      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [Colors.white, Colors.grey])
          ),
        child: StreamBuilder(
            stream: childDetailsRef.snapshots(),
            initialData: [],
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              // List<Child_Details> allrecords = snapshot.data;
              // print(allrecords);
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // return Container();
                  // return StudentList(
                  //     width: width,
                  //     height: height,
                  //     record: ChildDetailModel.fromDocument(
                  //         snapshot.data.doc[index]));
                  return ListWidget(
                      snapshot.data.docs[index]['child_name'],
                      snapshot.data.docs[index]['image_url'],
                      int.parse(snapshot.data.docs[index]['age']),
                      snapshot.data.docs[index]['created_on'].toDate(), () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => StudentAttendance()),
                    // );
                  });
                  // Navigation function needs to be passed
                },
              );
            }),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.filter),
      //     backgroundColor: Colors.yellow,
      //     onPressed: () {})
    );
  }
}
