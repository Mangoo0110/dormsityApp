import 'package:dartz/dartz.dart';
import 'package:dormsity/features/education/domain/entities/degree_field_of_study.dart';

import '../../../../core/api_handler/failure.dart';

import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../../../core/utils/classes/approve_details.dart';
import '../../../../core/utils/classes/domain.dart';
import '../datasources/remote/education_remote_datasource.dart';
import '../models/education_private_model.dart';

import '../../domain/entities/education_public.dart';

import '../../domain/entities/education_private.dart';

import '../../domain/repositories/education_repo.dart';
import '../models/education_public_model.dart';

class EducationRepoImpl implements EducationRepo {
  final EducationRemoteDataSource _educationRemoteDataSource;

  EducationRepoImpl(this._educationRemoteDataSource);

  @override
  Future<Either<DataCRUDFailure, Success>> approveGraduationComplete({required EducationPrv educationPrv}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _educationRemoteDataSource
          .approveGraduationComplete(educationPrv: EducationPrvModel.fromEntity(educationPrv))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> approveEducation({required EducationPrv educationPrv, required ApproveDetails approvDetails}) async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _educationRemoteDataSource
          .approveEducation(
              educationPrv: EducationPrvModel.fromEntity(educationPrv),
              approveDetails: approvDetails
          )
          .then((_) => Success());
    });
  }


  @override
  Future<Either<DataCRUDFailure, Success>> disApproveEducation({required EducationPrv educationPrv}) async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _educationRemoteDataSource
          .disApproveEducation(
              educationPrv: EducationPrvModel.fromEntity(educationPrv))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<EducationPrv>>> instituteApprovedEducations({required DomainUrl institutionDomain, required int paginationLimit}) async{
    return await asyncTryCatch<List<EducationPrv>>(tryFunc: () async {
      return await _educationRemoteDataSource
          .instituteApprovedEducations(institutionDomain: institutionDomain.url, paginationLimit: paginationLimit);
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<EducationPub>>> fetchUserEducations({required String userId}) async{
    return await asyncTryCatch<List<EducationPub>>(tryFunc: () async {
      return await _educationRemoteDataSource
          .fetchEducationsOfUser(userId: userId);
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> createEducation({required EducationPrv educationPrv}) async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _educationRemoteDataSource
          .createEducation(educationPrv: EducationPrvModel.fromEntity(educationPrv), educationPub: EducationPubModel.fromPrivateEntity(educationPrv))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<EducationPrv>>> institutePendingEducations({required DomainUrl institutionDomain, required int paginationLimit}) async{
    return await asyncTryCatch<List<EducationPrv>>(tryFunc: () async {
      return await _educationRemoteDataSource
          .institutePendingEducations(institutionDomain: institutionDomain.url, paginationLimit: paginationLimit);
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<EducationPrv>>> searchByIdEmail({required DomainUrl institutionDomain, required String studentIdOrEmail}) async{
    return await asyncTryCatch<List<EducationPrv>>(tryFunc: () async {
      return await _educationRemoteDataSource.searchByIdOrEmail(institutionDomain: institutionDomain.url, studentIdOrEmail: studentIdOrEmail);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<Degree>>> searchDegrees({required String text, required DomainUrl instituteDomain, int? paginationLimit, String? lastDegree}) async{
    return await asyncTryCatch<List<Degree>>(tryFunc: () async {
      return await _educationRemoteDataSource.searchDegrees(searchText: text, instituteDomain: instituteDomain, paginationLimit: paginationLimit, lastDegree: lastDegree);
    });
  }
  


  
}