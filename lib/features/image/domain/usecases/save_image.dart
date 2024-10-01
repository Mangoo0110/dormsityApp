import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/image.dart';
import '../repositories/image_repo.dart';

class SaveImage implements AsyncEitherUsecase<Success, ImageX>{

  final ImageRepo _imageRepo;

  SaveImage(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, Success>> call(ImageX params) async{
    return await _imageRepo.saveImage(image: params);
  }

}