import 'package:dartz/dartz.dart';
import '../entities/work_private.dart';
import '../entities/work_public.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';


abstract interface class WorkRoleRepo {

  Future<Either<DataCRUDFailure, Success>> saveWorkRole({required WorkRolePrv workRolePrv});

  Future<Either<DataCRUDFailure, Success>> approveWorkRole({required WorkRolePrv workRolePrv});

  Future<Either<DataCRUDFailure, Success>> approveWorkRoleComplete({required WorkRolePrv workRolePrv});

  /// Only admins of respective institutions can do a successful fetch of private work role list.
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> instituteWorkRolesPrv({required String institutionDomain, required int paginationLimit});

  /// Only admins of respective institutions can do a successful fetch of private work role list.
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> notApprovedWorkRoles({required String institutionDomain, required int paginationLimit});

  /// Only admins of institution can do a successful fetch of not approved teacher list.
  Future<Either<DataCRUDFailure, List<WorkRolePub>>> instituteWorkRolesPub({required String institutionDomain});

  Future<Either<DataCRUDFailure, List<WorkRolePub>>> userWorkRoles({required String userId});

  /// **Only user and admin feature.**
  Future<Either<DataCRUDFailure, List<WorkRolePrv>>> userWorkRolesPrivate({required String userId});
}
