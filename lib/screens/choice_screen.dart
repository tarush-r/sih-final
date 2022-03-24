import 'package:flutter/material.dart';
import 'package:sih_final/screens/dps_dashboard_screen.dart';
import 'package:sih_final/screens/lodge_complaint_screen.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-Buddy'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            // Container(
            //     child: Image.asset(
            //   'background.png',
            //   fit: BoxFit.fill,
            // )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // shrinkWrap: true,
                  // controller: scrollController,
                  // physics: BouncingScrollPhysics(),
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LodgeComplaint(
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
                            'Lodge a Complaint',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DpsDashboardScreen(
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
                            'Track',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    // buildDoneButton(
                    //     context: context,

                    //     function: () {},
                    //     title: 'Track',
                    //     height: 50,
                    //     customHeight: false,
                    //     maintainConstraints: false)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
