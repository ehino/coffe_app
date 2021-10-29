import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_and_firebase/models/brew.dart';
import 'package:flutter_and_firebase/models/user.dart';

class DatabaseService {

  //Create a collection in firestore
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  final String uid;
  DatabaseService ({this.uid});

  // Add user data to firestore using user id from firebase
  Future updateUserData (String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength
    });
  }

  //Brew list from snapshot
  List <Brew> _brewListFromSnapshot (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0
      );
    }).toList();
  }

  //get UserData from Snapsnot

  UserData _userDataFromSnapshot (DocumentSnapshot documentSnapshot) {
    return UserData(
      uid: uid,
      name: documentSnapshot.data['name'],
      sugars: documentSnapshot.data['sugars'],
      strength: documentSnapshot.data['strength']
    );
  }

  //Get collection (brews) stream
  Stream<List <Brew>> get brewSnapshot {
    return brewCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }
}