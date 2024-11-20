import 'dart:typed_data';

import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/image_repo.dart';

class SaveImageWithReferencePath implements AsyncEitherUsecase<String, SaveImageWithReferencePathParams>{

  final ImageRepo _imageRepo;

  SaveImageWithReferencePath(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, String>> call(SaveImageWithReferencePathParams params) async{
    return await _imageRepo.saveImageWithReferencePath(imageData: params.imageData, referencePath: params.referencePath);
  }

}

class SaveImageWithReferencePathParams{
  final String referencePath;
  final Uint8List imageData;

  SaveImageWithReferencePathParams({required this.referencePath, required this.imageData});
}