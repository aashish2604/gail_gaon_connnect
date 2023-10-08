import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseServices {
  final firebase = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getUserInfo() async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      final result = await firebase.collection("user").doc(uid).get();
      final response = result.data();
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: "Some error occured");
      return null;
    }
  }

  Future<String?> uploadImage(File file) async {
    try {
      final refernce = FirebaseStorage.instance.ref().child(file.path);
      await refernce.putFile(file);
      return refernce.getDownloadURL();
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  Future<void> addResaleItem(String sellItem, String type, double price,
      String description, String imageUrl) async {
    try {
      final userDetails = await getUserInfo();
      await firebase.collection("resale").doc().set({
        "buy_date": Timestamp.fromDate(DateTime.now()),
        "contact_no": userDetails!["contact_no"],
        "description": description,
        "image_url": imageUrl,
        "name": userDetails["name"],
        "price": price,
        "sell_item": sellItem,
        "type": type,
        "uid": FirebaseAuth.instance.currentUser!.uid
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<void> updateResaleItem(
      String docId,
      String sellItem,
      String type,
      double price,
      String description,
      String imageUrl,
      DateTime buyDate) async {
    try {
      final userDetails = await getUserInfo();
      await firebase.collection("resale").doc(docId).update({
        "buy_date": Timestamp.fromDate(buyDate),
        "contact_no": userDetails!["contact_no"],
        "description": description,
        "image_url": imageUrl,
        "name": userDetails["name"],
        "price": price,
        "sell_item": sellItem,
        "type": type,
        "uid": FirebaseAuth.instance.currentUser!.uid
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<void> deleteResaleItem(String docid) async {
    await FirebaseFirestore.instance.collection("resale").doc(docid).delete();
  }

  Future<void> addNewPool(String name, int noOfSeats, double price,
      String travellingFrom, String travellingTo, int vacantSeats) async {
    try {
      final userDetails = await getUserInfo();
      await firebase.collection("car_pooling").doc().set({
        "contact_no": userDetails!["contact_no"],
        "date": Timestamp.fromDate(DateTime.now()),
        "name": name,
        "no_of_seats": noOfSeats,
        "price": price,
        "travelling_from": travellingFrom,
        "travelling_to": travellingTo,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "vacant_seats": vacantSeats
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<void> updatePool(
      String name,
      int noOfSeats,
      double price,
      String travellingFrom,
      String travellingTo,
      int vacantSeats,
      String docId) async {
    try {
      final userDetails = await getUserInfo();
      await firebase.collection("car_pooling").doc(docId).set({
        "contact_no": userDetails!["contact_no"],
        "date": Timestamp.fromDate(DateTime.now()),
        "name": name,
        "no_of_seats": noOfSeats,
        "price": price,
        "travelling_from": travellingFrom,
        "travelling_to": travellingTo,
        "uid": FirebaseAuth.instance.currentUser!.uid,
        "vacant_seats": vacantSeats
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error");
    }
  }

  Future<void> deletePool(String docid) async {
    await FirebaseFirestore.instance
        .collection("car_pooling")
        .doc(docid)
        .delete();
  }
}
