import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_final/providers/approve_children_provider.dart';
import 'package:sih_final/screens/approve_tab.dart';
import 'package:sih_final/screens/rescue_tab.dart';

class ApproveTabsScreen extends StatefulWidget {
  @override
  State<ApproveTabsScreen> createState() => _ApproveTabsScreenState();
}

class _ApproveTabsScreenState extends State<ApproveTabsScreen> {

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   Provider.of<ApproveChildrenProvider>(context, listen: false).initData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.document_scanner)),
                Tab(icon: Icon(Icons.art_track)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              ApproveTab(),
              RescueTab(),
            ],
          ),
        ),
      ),
    );
  }
}
