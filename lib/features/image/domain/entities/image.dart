// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';


class ImageX {
  
  final String _id;
  final Uint8List image;

  ImageX({required String id, required this.image}): _id = id;

  String get path {
    final userAuth = AuthFirebaseImpl.instance.currentUserAuth;
    if(userAuth == null) return '';
    return '${userAuth.id}/images/$_id';
  }

  @override
  bool operator ==(covariant ImageX other) {
    if (identical(this, other)) return true;
  
    return 
      other._id == _id &&
      other.image == image;
  }

  @override
  int get hashCode => _id.hashCode ^ image.hashCode;
}



class ImagePath{
  String _path = '';
  final String _imageId;
  ImagePath({
    required String imageId,
  }): _imageId = imageId{
    _path = AuthFirebaseImpl.instance.currentUserAuth == null ? '' : "${AuthFirebaseImpl.instance.currentUserAuth!.id}/images/$imageId";
  }

  String get path => _path;

  String get imageId => _imageId;

}