import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';



abstract interface class ImageRemoteDatasource{
  Future<Uint8List?> fetchImage({required String path});

  Future<void> saveImage({required String path, required Uint8List image});

  Future<void> deleteImage({required String path});
}

class ImageFirebaseStorageImpl implements ImageRemoteDatasource{

  static ImageFirebaseStorageImpl? _instance;
  

  ImageFirebaseStorageImpl._();

  static ImageFirebaseStorageImpl get instance {
    _instance ??= ImageFirebaseStorageImpl._();
    return _instance!;
  }

  @override
  Future<void> deleteImage({required String path}) async{
    return FirebaseStorage.instance.ref(path).delete();
  }
  
  @override
  Future<Uint8List?> fetchImage({required String path}) async{
    if (kDebugMode) {
      print("path is $path ${'\n\n'}");
    }
    return await FirebaseStorage.instance.ref(path).getData();
  }
  
  @override
  Future<void> saveImage({required String path, required Uint8List image}) async{
    await FirebaseStorage.instance.ref(path).putData(image);
  }
}