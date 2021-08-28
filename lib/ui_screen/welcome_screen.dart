import 'package:flutter/material.dart';
import 'home_page.dart';
import 'admin_page.dart';
import 'cart_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentIndex = 0;
  List widgetOptions = [
    MyHomePage(),
    CartScreen(),
    AdminPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              // title: Text('home'),
              label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart_outlined,
              ),
              //      title: Text('home'),
              label: 'cart'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline_outlined,
              ),
              //  title: Text('Admin'),
              label: 'admin'),
        ],
        currentIndex: currentIndex,
      ),
      body: widgetOptions.elementAt(currentIndex),
    );
  }
}
