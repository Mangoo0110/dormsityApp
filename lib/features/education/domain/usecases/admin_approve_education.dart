import 'package:dartz/dartz.dart';
import '../../../../core/utils/classes/approve_details.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/education_repo.dart';

import '../entities/education_private.dart';

class ApproveEducation implements AsyncEitherUsecase<Success, ApproveEducationParams>{
  final EducationRepo _studentEducationRepo;

  ApproveEducation(this._studentEducationRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(ApproveEducationParams params) async{
    return await _studentEducationRepo.approveEducation(educationPrv: params.educationPrv, approvDetails: params.approveDetails);
  }
  
}

class ApproveEducationParams {
  final EducationPrv educationPrv;
  final ApproveDetails approveDetails;

  ApproveEducationParams({required this.educationPrv, required this.approveDetails});
}