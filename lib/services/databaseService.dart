import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService(
      {this.uid}); //whenever a user signs up, we store the uid

  //collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    //when the uid, we can create a document for the brew collection
    await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //brew list from query snapshot
  List<Brew> _getBrewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((e) {
      return Brew(
          name: e.data['name'] ?? '',
          sugars: e.data['sugars'] ?? '',
          strength: e.data['strength'] ?? 0);
    }).toList();
  }

  //user data object from document snapshot
  UserData _getUserDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid!,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  //get brews collection stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_getBrewListFromSnapShot);
  }


  //get user document stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_getUserDataFromSnapShot);
  }
}
