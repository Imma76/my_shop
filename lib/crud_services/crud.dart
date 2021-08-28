import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseServices {
  Future<void> addProductsToForYou(Map data) async {
    await FirebaseFirestore.instance
        .collection('for_you_products')
        .add(data)
        .then((value) => print(value));
  }

  Future<void> addProductsToHotList(Map data) async {
    await FirebaseFirestore.instance
        .collection('HotLists')
        .add(data)
        .then((value) => print(value));
  }

  Future getForYouData() async {
    return await FirebaseFirestore.instance
        .collection('for_you_products')
        .snapshots();
  }

  Future getHotListData() async {
    return await FirebaseFirestore.instance.collection('HotLists').snapshots();
  }

  deleteFyItems(var index) async {
    var id = await FirebaseFirestore.instance
        .collection('for_you_products')
        .doc(index)
        .delete();
  }

  deleteHtItems(var index) async {
    var id = await FirebaseFirestore.instance
        .collection('HotLists')
        .doc(index)
        .delete();
  }
}
