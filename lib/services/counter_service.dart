import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CounterService {
  final CollectionReference counters = FirebaseFirestore.instance.collection('counters');

  Future<void> addCounter(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await counters.add({
      'userId': user.uid,
      'name': name,
      'value': 0,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getUserCounters() {
    final user = FirebaseAuth.instance.currentUser;
    return counters.where('userId', isEqualTo: user?.uid).snapshots();
  }

  Future<void> incrementCounter(String docId, int currentValue) async {
    await counters.doc(docId).update({'value': currentValue + 1});
  }

  Future<void> deleteCounter(String docId) async {
    await counters.doc(docId).delete();
  }
}
