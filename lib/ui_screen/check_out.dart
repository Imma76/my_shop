import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CheckOut extends StatefulWidget {
  // const CheckOut({ Key? key }) : super(key: key);

  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(hintText: 'Your Name'),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Your Phone No'),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Your Address'),
        ),
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(hintText: 'Your email'),
        ),
        Container(child: Text('total = 33,000')),
        ElevatedButton(
          onPressed: () {},
          child: Text('Continue to payment'),
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlueAccent,
          ),
        )
      ],
    ));
  }
}
