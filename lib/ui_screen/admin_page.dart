import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../admin_panel/add_section/add_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Image.asset('images/admin.png'),
            ),
            FlatButton(
              minWidth: double.infinity,
              child: Text('Add Product'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AddPage();
                }));
              },
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
