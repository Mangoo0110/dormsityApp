import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/image.dart';
import '../repositories/image_repo.dart';

class FetchImage implements AsyncEitherUsecase<ImageX?, ImagePath>{

  final ImageRepo _imageRepo;

  FetchImage(this._imageRepo);
  @override
  Future<Either<DataCRUDFailure, ImageX?>> call(ImagePath params) async{
    return await _imageRepo.fetchImage(imagePath: params);
  }

}