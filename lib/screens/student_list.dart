import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:interview_prep/models/childdetails.dart';
import 'package:sih_final/models/child_detail_model.dart';

// class StudentList extends StatelessWidget {
//   // const StudentList({ Key? key }) : super(key: key);
//   final width;
//   final height;
//   ChildDetailModel record;
//   StudentList({this.width, this.height, this.record});
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber[400],
//         leading: GestureDetector(
//             child: Icon(Icons.arrow_back_ios),
//             onTap: () {
//               Navigator.of(context).pop();
//             }),
//         title: Text('Student List'),
//       ),
//       body: new Column(
//         children: <Widget>[
//           new ListWidget(widget.record.name, widget.record.imageUrl,
//               widget.record.age, widget.record.createdon),
//         ],
//       ),
//     );
//   }
// }

class ListWidget extends StatelessWidget {
  // const ListWidget({ Key? key }) : super(key: key);
  final String name;
  final String imageUrl;
  final int age;
  final DateTime enrolledDate;
  final Function pageName;
  ListWidget(
      this.name, this.imageUrl, this.age, this.enrolledDate, this.pageName);

  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Positioned(
      child: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        radius: 50,
        // margin: new EdgeInsets.symmetric(vertical: 16.0),
        // alignment: FractionalOffset.centerLeft,
        // child: new Image(
        //   image: new NetworkImage(imageUrl),
        //   height: 92.0,
        //   width: 92.0,
        // ),
      ),
      top: 10,
    );
    final planetCard = new Container(
      margin: const EdgeInsets.only(left: 45.0, right: 24.0),
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
              name,
              style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 24.0),
            ),
            new Text(
              "Enrolled On: $enrolledDate",
              style: TextStyle(
                  color: Color(0x66FFFFFF),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  fontSize: 14.0),
            ),
            new Container(
                color: const Color(0xFF00C6FF),
                width: 24.0,
                height: 1.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0)),
            new Row(
              children: <Widget>[
                new Icon(Icons.location_on,
                    size: 14.0, color: Color(0x66FFFFFF)),
                new Text(
                  "Age: $age",
                  style: TextStyle(
                      color: Color(0x66FFFFFF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0),
                ),
                new Container(width: 24.0),
                new Icon(Icons.flight_land,
                    size: 14.0, color: Color(0x66FFFFFF)),
                new Text(
                  "Text 3",
                  style: TextStyle(
                      color: Color(0x66FFFFFF),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w300,
                      fontSize: 12.0),
                ),
              ],
            )
          ],
        ),
      ),
    );

    return GestureDetector(
        onTap: pageName,
        child: new Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24.0,
            ),
            child: new Stack(
              children: <Widget>[
                planetCard,
                planetThumbnail,
              ],
            )));
  }
}
