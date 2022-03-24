import 'package:flutter/material.dart';
import 'package:sih_final/screens/approve_tabs_screen.dart';
import 'package:sih_final/screens/attendance_students_list.dart';

class DpsDashboardScreen extends StatefulWidget {
  @override
  State<DpsDashboardScreen> createState() => _DpsDashboardScreenState();
}

class _DpsDashboardScreenState extends State<DpsDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ApproveTabsScreen(
                          // childId: childId,
                          )),
                );
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  'Approve Complaints',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendanceStudentsList(
                          // childId: childId,
                          )),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => LodgeComplaint(
                //           // childId: childId,
                //           )),
                // );
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Text(
                  'Attendance Tracking',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
