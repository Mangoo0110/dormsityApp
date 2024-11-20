
import 'dart:collection';
import 'dart:io';

import 'package:dormsity/core/api_handler/exceptions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/utils/func/dekhao.dart';


abstract interface class ImageRemoteDatasource{
  Future<ImageX> fetchImage({required String imageUrl, bool? forceFetch});

  Future<String> saveImageWithUrl({required String existingImageUrl, required Uint8List image});

  Future<String> saveImageWithReferencePath({required String referencePath, required Uint8List image});

  Future<void> deleteImage({required String imageUrl});
}

class ImageFirebaseStorageImpl implements ImageRemoteDatasource{


  final SplayTreeMap<String, ImageX> _images = SplayTreeMap<String, ImageX>();

  static ImageFirebaseStorageImpl? _instance;
  

  ImageFirebaseStorageImpl._();

  static ImageFirebaseStorageImpl get instance {
    _instance ??= ImageFirebaseStorageImpl._();
    return _instance!;
  }

  @override
  Future<void> deleteImage({required String imageUrl}) async{
    return FirebaseStorage.instance.ref(imageUrl).delete();
  }
  
  @override
  Future<ImageX> fetchImage({required String imageUrl, bool? forceFetch}) async{
    

    final storageRef = FirebaseStorage.instance.refFromURL(imageUrl);

    if (kDebugMode) {
      print("path is $imageUrl ${'\n\n'}");
      print("url is ${storageRef.fullPath} ${'\n\n'}");
    }

    if(forceFetch != true && _images.containsKey(storageRef.fullPath) 
        && _images[storageRef.fullPath]!.fetchedAt.difference(DateTime.now()).inSeconds < 60 * 10
      ) {
        dekhao("image exist; url is ${storageRef.fullPath} ${'\n\n'}");
        return _images[storageRef.fullPath]!;
      }
      
    return await storageRef.getData().then((data){
      if(data == null) throw NoDataException();
      dekhao("fetched url is ${storageRef.fullPath} ${'\n\n'}");
      _images[storageRef.fullPath] = ImageX._(url: storageRef.fullPath, image: data);
      return ImageX._(url: imageUrl, image: data);
    });
  }

  @override
  Future<String> saveImageWithUrl({required String existingImageUrl, required Uint8List image}) async{

    Reference storageRef = FirebaseStorage.instance.refFromURL(existingImageUrl);

    // Upload the file
      try {
        return await storageRef.putData(image).then((ts) async{
          if(!(ts.state == TaskState.success)) throw PathNotFoundException(storageRef.fullPath, const OSError());
          final url = await storageRef.getDownloadURL();
          _images[storageRef.fullPath] = ImageX._(url: url, image: image);
          return url;
        });
      } catch (e) {
        dekhao(e.toString());
        rethrow;
      }
    
  }


  @override
  Future<String> saveImageWithReferencePath({required String referencePath, required Uint8List image}) async{
      
    // Create a storage reference
      Reference storageRef = FirebaseStorage.instance.ref().child(referencePath);


    // Upload the file
      return await storageRef.putData(image).then((ts) async{
        if(!(ts.state == TaskState.success)) throw PathNotFoundException(storageRef.fullPath, const OSError());
        final url = await storageRef.getDownloadURL();
        _images[storageRef.fullPath] = ImageX._(url: url, image: image);
        return url;
      });
    
  }
}




class ImageX {
  
  final String url;
  late DateTime _fetchedAt;
  final Uint8List image;

  ImageX._({required this.url, required this.image}){
    _fetchedAt = DateTime.now();
  }

  //getters

  DateTime get fetchedAt => _fetchedAt;

  @override
  bool operator ==(covariant ImageX other) {
    if (identical(this, other)) return true;
  
    return 
      other.url == url &&
      other._fetchedAt == _fetchedAt &&
      other.image == image;
  }

  @override
  int get hashCode => url.hashCode ^ _fetchedAt.hashCode ^ image.hashCode;
}
