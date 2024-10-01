
import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../entities/image.dart';

abstract interface class ImageRepo{
  Future<Either<DataCRUDFailure, ImageX?>> fetchImage({required ImagePath imagePath});

  Future<Either<DataCRUDFailure, Success>> saveImage({required ImageX image});

  Future<Either<DataCRUDFailure, Success>> deleteImage({required String path});
}