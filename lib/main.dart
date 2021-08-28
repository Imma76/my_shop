import 'package:flutter/material.dart';
import 'package:my_shop/ui_screen/onboarding.dart';
import 'package:provider/provider.dart';
import 'models/cart_model/cart_model.dart';
import 'ui_screen/welcome_screen.dart';
import 'models/product_models/hot_list.dart';
import 'models/product_models/for_you_list.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HotList()),
      ChangeNotifierProvider(create: (_) => ForYouList()),
      ChangeNotifierProvider(create: (_) => Cart()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoardingPage(),
    );
  }
}
