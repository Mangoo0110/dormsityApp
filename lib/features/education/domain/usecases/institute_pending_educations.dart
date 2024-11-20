import 'package:dartz/dartz.dart';
import '../../../../core/utils/classes/domain.dart';
import '../entities/education_private.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/education_repo.dart';


class InstitutePendingEducations implements AsyncEitherUsecase<List<EducationPrv>, DomainUrl>{
  final EducationRepo _educationRepo;

  InstitutePendingEducations(this._educationRepo);

  @override
  Future<Either<DataCRUDFailure, List<EducationPrv>>> call(DomainUrl params) async{
    return await _educationRepo.institutePendingEducations(institutionDomain: params, paginationLimit: 100);
  }
  
}
