import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepoProvider = Provider(
  (ref) => CommonFirebaseStorageRepo(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorageRepo {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepo({
    required this.firebaseStorage,
  });

  Future<String> storeToFilestore(String ref, File file) async {
    // we are communicating with the firebase console
    //the path is where the data os going to be stored
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
