import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/image_repo.dart';

class SaveImageWithUrl implements AsyncEitherUsecase<String, SaveImageWithUrlParams>{

  final ImageRepo _imageRepo;

  SaveImageWithUrl(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, String>> call(SaveImageWithUrlParams params) async{
    return await _imageRepo.saveImageWithUrl(imageData: params.imageData, existingImageUrl: params.imageUrl);
  }

}

class SaveImageWithUrlParams{
  final String imageUrl;
  final Uint8List imageData;

  SaveImageWithUrlParams({required this.imageUrl, required this.imageData});
}