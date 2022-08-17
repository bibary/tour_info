import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'main/favoritePage.dart';
import 'main/mapPage.dart';
import 'main/settingPage.dart';

class MainPage extends StatefulWidget {
  final Future<Database> database;
  MainPage(this.database);
  @override
  State<StatefulWidget> createState() => _MainPage();
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  TabController controller = null;
  FirebaseDatabase _database = null;
  DatabaseReference reference = null;
  String _databaseURL = 'https://infotour-869cd-default-rtdb.firebaseio.com';
  String id = null;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.reference().child('tour');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: TabBarView(
          children: <Widget>[
            // TabBarView에 채울 위젯들
            MapPage(
              databaseReference: reference,
              db: widget.database,
              id: id,
            ),
            FavoritePage(
              databaseReference: reference,
              db: widget.database,
              id: id,
            ),
            SettingPage()
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.map),
            ),
            Tab(
              icon: Icon(Icons.star),
            ),
            Tab(
              icon: Icon(Icons.settings),
            )
          ],
          labelColor: Colors.amber,
          indicatorColor: Colors.deepOrangeAccent,
          controller: controller,
        ));
  }
}
