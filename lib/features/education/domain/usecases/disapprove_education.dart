import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/education_repo.dart';

import '../entities/education_private.dart';

class DisApproveEducation implements AsyncEitherUsecase<Success, EducationPrv>{
  final EducationRepo _studentEducationRepo;

  DisApproveEducation(this._studentEducationRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(EducationPrv params) async{
    return await _studentEducationRepo.disApproveEducation(educationPrv: params);
  }
  
}