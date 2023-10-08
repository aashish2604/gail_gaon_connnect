import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sjs_app/models/resale_model.dart';

class ResaleRepository {
  Future<List<ResaleModel>> getAvailableItems() async {
    try {
      final collection =
          await FirebaseFirestore.instance.collection('resale').get();
      final docList = collection.docs;
      List<ResaleModel> modelList = [];
      for (var doc in docList) {
        modelList.add(ResaleModel.fromJson(doc.data()));
      }
      return modelList;
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Some error occured");
      return [];
    }
  }

  Stream<List<ResaleModel>> getAvailableItemsStream() {
    try {
      final collection = FirebaseFirestore.instance.collection('resale');

      return collection.snapshots().map((QuerySnapshot querySnapshot) {
        List<ResaleModel> modelList = [];

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data =
              doc.data() as Map<String, dynamic>; // Cast data to Map
          data.addAll({"doc_id": doc.id});
          modelList.add(ResaleModel.fromJson(data));
        }
        return modelList;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Some error occurred");
      return Stream.value([]);
    }
  }
}
