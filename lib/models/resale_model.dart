import 'package:cloud_firestore/cloud_firestore.dart';

class ResaleModel {
  DateTime buyDate;
  String contactNo;
  String description;
  String imageUrl;
  String name;
  double price;
  String sellItem;
  String type;
  String uid;
  String docId;

  ResaleModel(
      {required this.buyDate,
      required this.contactNo,
      required this.description,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.sellItem,
      required this.type,
      required this.uid,
      required this.docId});

  factory ResaleModel.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['buy_date'];
    DateTime buyDate = timestamp.toDate();
    return ResaleModel(
        buyDate: buyDate,
        contactNo: json['contact_no'],
        description: json['description'],
        imageUrl: json['image_url'],
        name: json['name'],
        price: (json['price'] is double)
            ? (json['price'])
            : json['price'].toDouble(),
        sellItem: json['sell_item'],
        type: json['type'],
        uid: json['uid'],
        docId: json['doc_id']);
  }

  Map<String, dynamic> toJson(String uid) => {
        'buy_date': Timestamp.fromDate(buyDate),
        'contact_no': contactNo,
        'description': description,
        'image_url': imageUrl,
        'name': name,
        'price': price,
        'sell_item': sellItem,
        'type': type,
        'uid': uid,
      };
}
