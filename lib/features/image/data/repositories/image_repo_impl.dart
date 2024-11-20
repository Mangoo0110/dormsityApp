

import 'dart:typed_data';

import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/repositories/image_repo.dart';
import '../datasources/firebase/image_firebase_datasource.dart';

class ImageRepoImpl implements ImageRepo{

  final ImageRemoteDatasource _imageRemoteDatasource;

  ImageRepoImpl(this._imageRemoteDatasource);

  @override
  Future<Either<DataCRUDFailure, ImageX>> fetchImage({required String url, bool? forceFetch}) async{
    return asyncTryCatch<ImageX>(tryFunc: ()async{
      return await _imageRemoteDatasource.fetchImage(imageUrl: url);
    });
  }

  @override
  Future<Either<DataCRUDFailure, String>> saveImageWithUrl({required Uint8List imageData, required String existingImageUrl}) async{
    return asyncTryCatch<String>(tryFunc: ()async{
      return await _imageRemoteDatasource.saveImageWithUrl(existingImageUrl: existingImageUrl, image: imageData);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> deleteImage({required String imageUrl}) async{
    return asyncTryCatch<Success>(tryFunc: ()async{
      return await _imageRemoteDatasource.deleteImage(imageUrl: imageUrl).then((value) => Success());
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, String>> saveImageWithReferencePath({required String referencePath, required Uint8List imageData}) async{
    return  asyncTryCatch<String>(tryFunc: () async{
      return await _imageRemoteDatasource.saveImageWithReferencePath(referencePath: referencePath, image: imageData);
    });
  }

}