import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sih_final/models/attendance_model.dart';
import 'package:sih_final/models/child_detail_model.dart';
// import 'package:interview_prep/models/childdetails.dart';

class StudentAttendance extends StatelessWidget {
  // const StudentAttendance({ Key? key }) : super(key: key);
  // final width;
  // final height;
  AttendanceModel record;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[400],
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            }),
        title: Text("Detail Page"),
      ),
      body: new Column(
        children: <Widget>[
          new AttendanceWidget(record.startDate, record.endDate,
              record.workingDays, record.absentDays),
        ],
      ),
    );
  }
}

class AttendanceWidget extends StatelessWidget {
  // const AttendanceWidget({ Key? key }) : super(key: key);

  final DateTime fromDate;
  final DateTime endDate;
  final int totalDays;
  final int absentDays;
  // final Function pageName;
  AttendanceWidget(
    this.fromDate,
    this.endDate,
    this.totalDays,
    this.absentDays,
  );

  @override
  Widget build(BuildContext context) {
    final percentage = (totalDays - absentDays) / totalDays;
    // final planetThumbnail = new Container(
    //   margin: new EdgeInsets.symmetric(vertical: 16.0),
    //   alignment: FractionalOffset.centerLeft,
    //   child: new Image(
    //     image: new NetworkImage(imageUrl),
    //     height: 92.0,
    //     width: 92.0,
    //   ),
    // );
    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 24.0, right: 24.0),
      decoration: new BoxDecoration(
        color: Color(0xFF8685E5),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              offset: new Offset(0.0, 10.0))
        ],
      ),
      child: new Container(
        margin: const EdgeInsets.only(top: 16.0, left: 72.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              "Percentage: " + percentage.toString(),
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0),
            ),
            // new Text(
            //   "Percentage:",
            //   style: TextStyle(
            //       color: Color(0x66FFFFFF),
            //       fontFamily: 'Poppins',
            //       fontWeight: FontWeight.w300,
            //       fontSize: 14.0),
            // ),
            new Container(
                color: const Color(0xFF00C6FF),
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            new Column(children: [
              Row(
                children: <Widget>[
                  new Icon(Icons.start, size: 14.0, color: Color(0x66FFFFFF)),
                  new SizedBox(
                    width: 5,
                  ),
                  new Text(
                    "From: " + fromDate.toString(),
                    style: TextStyle(
                        color: Color(0x66FFFFFF),
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0),
                  ),
                  new Container(width: 24.0),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                new Icon(Icons.date_range_sharp,
                    size: 14.0, color: Color(0x66FFFFFF)),
                new SizedBox(
                  width: 5,
                ),
                new Text(
                  "To: " + endDate.toString(),
                  style: TextStyle(
                      color: Color(0x66FFFFFF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0),
                ),
              ]),
            ])
          ],
        ),
      ),
    );

    return GestureDetector(
        onTap: () {
          // pageName;
        },
        child: new Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: new Stack(
              children: <Widget>[
                planetCard,
                // planetThumbnail,
              ],
            )));
  }
}
