import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../models/work_private_model.dart';
import '../models/work_public_model.dart';
import '../../domain/entities/work_private.dart';
import '../../domain/entities/work_public.dart';
import '../../domain/repositories/work_repository.dart';


import '../datasources/remote/work_role_remote_datasource.dart';

class WorkRoleRepoImpl implements WorkRoleRepo {
  final WorkRoleRemoteDataSource _workRoleRemoteDataSource;

  WorkRoleRepoImpl(this._workRoleRemoteDataSource);

  @override
  Future<Either<DataCRUDFailure, Success>> approveWorkRole(
      {required WorkRolePrv workRolePrv}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _workRoleRemoteDataSource
          .approveWorkRole(workRolePrv: WorkRolePrvModel.fromEntity( workRolePrv))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> approveWorkRoleComplete({required WorkRolePrv workRolePrv}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _workRoleRemoteDataSource
          .approveWorkRole(workRolePrv: WorkRolePrvModel.fromEntity( workRolePrv))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> instituteWorkRolesPrv({required String institutionDomain, required int paginationLimit}) async {
    return await asyncTryCatch<List<WorkRolePrvModel>>(tryFunc: () async {
      return await _workRoleRemoteDataSource.instituteWorkRolesPrv(institutionDomain: institutionDomain, paginationLimit: paginationLimit);
    });
  }


  @override
  Future<Either<DataCRUDFailure, Success>> saveWorkRole({required WorkRolePrv workRolePrv}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _workRoleRemoteDataSource
          .saveWorkRole(workRolePrv: WorkRolePrvModel.fromEntity(workRolePrv))
          .then((_) => Success());
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<WorkRolePub>>> instituteWorkRolesPub({required String institutionDomain}) async {
    return await asyncTryCatch<List<WorkRolePubModel>>(tryFunc: () async {
      return await _workRoleRemoteDataSource.instituteWorkRolesPub(
          institutionDomain: institutionDomain);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<WorkRolePub>>> userWorkRoles({required String userId}) async {
    return await asyncTryCatch<List<WorkRolePubModel>>(tryFunc: () async {
      return await _workRoleRemoteDataSource.userWorkRoles(
          userId: userId);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> notApprovedWorkRoles({required String institutionDomain, required int paginationLimit}) async{
    return await asyncTryCatch<List<WorkRolePrvModel>>(tryFunc: () async {
      return await _workRoleRemoteDataSource.notApprovedWorkRoles(institutionDomain: institutionDomain, paginationLimit: paginationLimit);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> userWorkRolesPrivate({required String userId}) async {
    return await asyncTryCatch<List<WorkRolePrvModel>>(tryFunc: () async {
      return await _workRoleRemoteDataSource.userWorkRolesPrv(userId: userId,);
    });
  }
}
