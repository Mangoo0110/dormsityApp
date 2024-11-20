
import 'dart:typed_data';

import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../data/datasources/firebase/image_firebase_datasource.dart';

abstract interface class ImageRepo{
  Future<Either<DataCRUDFailure, ImageX>> fetchImage({required String url, bool? forceFetch});

  Future<Either<DataCRUDFailure, String>> saveImageWithUrl({required Uint8List imageData, required String existingImageUrl});

  Future<Either<DataCRUDFailure, String>> saveImageWithReferencePath({required String referencePath, required Uint8List imageData});

  Future<Either<DataCRUDFailure, Success>> deleteImage({required String imageUrl});
}