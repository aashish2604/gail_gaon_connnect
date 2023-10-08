import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sjs_app/models/pooling_model.dart';

class PoolingRepository {
  Future<List<PoolingModel>> getAvailableItems() async {
    try {
      final collection =
          await FirebaseFirestore.instance.collection('car_pooling').get();
      final docList = collection.docs;
      List<PoolingModel> modelList = [];
      for (var doc in docList) {
        modelList.add(PoolingModel.fromJson(doc.data()));
      }
      return modelList;
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Some error occured");
      return [];
    }
  }

  Stream<List<PoolingModel>> getAllPoolStream() {
    try {
      final collection = FirebaseFirestore.instance.collection('car_pooling');

      return collection.snapshots().map((QuerySnapshot querySnapshot) {
        List<PoolingModel> modelList = [];

        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data =
              doc.data() as Map<String, dynamic>; // Cast data to Map
          data.addAll({"doc_id": doc.id});
          modelList.add(PoolingModel.fromJson(data));
        }
        return modelList;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Some error occurred");
      return Stream.value([]);
    }
  }
}
