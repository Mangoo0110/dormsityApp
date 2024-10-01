import 'dart:collection';
import 'dart:typed_data';


import 'package:flutter/material.dart';

import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/image.dart';
import '../../domain/usecases/fetch_image.dart';

class AppImageProvider extends ChangeNotifier{
  
  final SplayTreeMap<String, ImageX> _images = SplayTreeMap<String, ImageX>();
  final SplayTreeMap<String, DateTime> _timeLastFetchedAnImaage = SplayTreeMap<String, DateTime>();

  AppImageProvider();

  Future<ImageX?> fetchImage({required String imageId})async{
    if(_images.containsKey(imageId) || _timeLastFetchedAnImaage.containsKey(imageId) && _timeLastFetchedAnImaage[imageId]!.difference(DateTime.now()).inSeconds > 1200) return _images[imageId];
    return await serviceLocator<FetchImage>().call(ImagePath(imageId: imageId)).then((value) {
      return value.fold(
        (l) {
          return null;
        }, (r) {
          if(r == null) return null;
          _images[imageId] = r;
          return r;
        });
    });
  }
  Uint8List? findImage({required String imageId}){
    final image = _images[imageId];
    if(image == null) dekhao("image not found");
    return _images[imageId]?.image;
  }
}