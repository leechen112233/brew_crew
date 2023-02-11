import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});//whenever a user signs up, we store the uid

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserDate(String sugars, String name, int strength) async {
    //when the uid, we can create a document for the brew collection
    await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }

  //get brews collection stream
  Stream<QuerySnapshot> get brews{
    return brewCollection.snapshots();
  }
}