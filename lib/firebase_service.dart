import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterlist/userdata.dart';

class FirebaseService{
  static final COLLECTION_REF = 'user';

  final firestore = FirebaseFirestore.instance;
  late final CollectionReference userRef;

  FirebaseService(){
    userRef = firestore.collection(COLLECTION_REF);
  }

// mengambil dan menampilkan data di firebase ke ui
  Stream<QuerySnapshot<Object?>> ambilData(){
    return userRef.snapshots(); //snapshots akan mengambil seluruh data di collection
    
  }

//TAMBAH
  void tambah(UserData userData){
    DocumentReference documentReference = userRef.doc(userData.nama); //nama doc diambil dari nama
    documentReference.set(userData.toJson());
  }

//HAPUS
  void hapus(UserData userData){
    DocumentReference documentReference = userRef.doc(userData.nama);
    documentReference.delete();
  }

//UBAH
  void ubah(UserData userData){
    DocumentReference documentReference = userRef.doc(userData.nama);//key nya nama
    documentReference.update(userData.toJson());
  }
}