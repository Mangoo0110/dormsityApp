import 'package:dartz/dartz.dart';
import '../entities/work_public.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/classes/domain.dart';
import '../repositories/work_repository.dart';

class FetchInstituteWorkRolesPub implements AsyncEitherUsecase<List, DomainUrl> {
  final WorkRoleRepo _workRepo;

  FetchInstituteWorkRolesPub(this._workRepo);

  @override
  Future<Either<DataCRUDFailure, List<WorkRolePub>>> call(DomainUrl params) async {
    return await _workRepo.instituteWorkRolesPub(
        institutionDomain: params.url);
  }
}


