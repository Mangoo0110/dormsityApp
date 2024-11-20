import 'package:dartz/dartz.dart';
import '../../../../core/utils/classes/domain.dart';
import '../entities/education_private.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/education_repo.dart';


class InstituteApprovedEducations implements AsyncEitherUsecase<List<EducationPrv>, FetchInstituteEducationsParams>{
  final EducationRepo _studentEducationRepo;

  InstituteApprovedEducations(this._studentEducationRepo);

  @override
  Future<Either<DataCRUDFailure, List<EducationPrv>>> call(FetchInstituteEducationsParams params) async{
    return await _studentEducationRepo.instituteApprovedEducations(institutionDomain: params.domain, paginationLimit: params.paginationLimit);
  }
  
}

class FetchInstituteEducationsParams {
  final DomainUrl domain;
  final int paginationLimit;

  FetchInstituteEducationsParams({required this.domain, required this.paginationLimit});
}