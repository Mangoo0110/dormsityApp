

import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/entities/image.dart';
import '../../domain/repositories/image_repo.dart';
import '../datasources/firebase/image_firebase_datasource.dart';

class ImageRepoImpl implements ImageRepo{

  final ImageRemoteDatasource _imageRemoteDatasource;

  ImageRepoImpl(this._imageRemoteDatasource);

  @override
  Future<Either<DataCRUDFailure, ImageX?>> fetchImage({required ImagePath imagePath}) async{
    return asyncTryCatch<ImageX?>(tryFunc: ()async{
      return await _imageRemoteDatasource.fetchImage(path: imagePath.path).then((value) {
        if(value == null) return null;
        return ImageX(id: imagePath.imageId, image: value);
      });
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> saveImage({required ImageX image}) async{
    return asyncTryCatch<Success>(tryFunc: ()async{
      return await _imageRemoteDatasource.saveImage(path: image.path, image: image.image).then((value) => Success());
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> deleteImage({required String path}) async{
    return asyncTryCatch<Success>(tryFunc: ()async{
      return await _imageRemoteDatasource.deleteImage(path: path).then((value) => Success());
    });
  }

}