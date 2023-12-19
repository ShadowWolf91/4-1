import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreService{
  final CollectionReference musics=FirebaseFirestore.instance.collection('music2');

  Future<void> addMusic(String album,String artist,String genre){
    return musics.add({
      'genre':genre,
      'timestamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getMusicStream(){
    final musicStream= musics.orderBy('timestamp', descending: true).snapshots();
    return musicStream;
  }

Future<void> updateMusic(String docId, String newAlbum){
    return musics.doc(docId).update({
      'genre':newAlbum
    });
}

  Future<void> deleteMusic(String docId){
    return musics.doc(docId).delete();
  }

}