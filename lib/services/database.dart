import 'package:notting/models/brew.dart';
import 'package:notting/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;

  DataBaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({"sugars": sugars, "name": name, "strength": strength});
  }

  // brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'],
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? "0");
    }).toList();
  }

  // userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  // get brews streams
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

  // get user doc
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
