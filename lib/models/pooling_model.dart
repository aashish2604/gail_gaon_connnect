import 'package:cloud_firestore/cloud_firestore.dart';

class PoolingModel {
  String contactNo;
  DateTime date;
  String name;
  int noOfSeats;
  double price;
  String travellingFrom;
  String travellingTo;
  String uid;
  int vacantSeats;
  String docId;

  PoolingModel(
      {required this.contactNo,
      required this.date,
      required this.name,
      required this.noOfSeats,
      required this.price,
      required this.travellingFrom,
      required this.travellingTo,
      required this.uid,
      required this.vacantSeats,
      required this.docId});

  factory PoolingModel.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['date'];
    DateTime date = timestamp.toDate();
    return PoolingModel(
        contactNo: json['contact_no'],
        date: date,
        name: json['name'],
        noOfSeats: json['no_of_seats'],
        price: (json['price'] is double)
            ? (json['price'])
            : json['price'].toDouble(),
        travellingFrom: json['travelling_from'],
        travellingTo: json['travelling_to'],
        uid: json['uid'],
        vacantSeats: json['vacant_seats'],
        docId: json['doc_id']);
  }
}
