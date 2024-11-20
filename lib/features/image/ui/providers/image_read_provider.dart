

import 'package:dormsity/core/utils/func/dekhao.dart';
import 'package:flutter/material.dart';

import '../../../../init_dependency.dart';
import '../../data/datasources/firebase/image_firebase_datasource.dart';
import '../../domain/usecases/fetch_image.dart';

class ImageReadProvider extends ChangeNotifier{
  

  ImageReadProvider();

  Future<ImageX?> fetchImage({required String imageUrl, bool? forceFetch})async{
    dekhao("imageUrl is $imageUrl");
    if(imageUrl.isEmpty) return null;
    return await serviceLocator<FetchImage>().call(FetchImageParams(url: imageUrl, forceFetch: false)).then((value) {
        return value.fold(
          (l) {
            return null;
          }, (r) {
            return r;
          });
    });
  }

}