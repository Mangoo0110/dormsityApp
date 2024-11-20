import 'package:dartz/dartz.dart';
import '../../../../core/utils/classes/approve_details.dart';
import '../../../../core/utils/classes/domain.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';

import '../entities/degree_field_of_study.dart';
import '../entities/education_public.dart';
import '../entities/education_private.dart';

abstract interface class EducationRepo {
  
  Future<Either<DataCRUDFailure, Success>> createEducation({required EducationPrv educationPrv});

  Future<Either<DataCRUDFailure, Success>> approveEducation({required EducationPrv educationPrv, required ApproveDetails approvDetails});

  Future<Either<DataCRUDFailure, Success>> disApproveEducation({required EducationPrv educationPrv});

  Future<Either<DataCRUDFailure, Success>> approveGraduationComplete({required EducationPrv educationPrv});

  /// Returns student's education list that are pursuing or completed.
  /// 
  /// ***Only admins of respective institutions can do a successful fetch of education list of respective institutes***.
  Future<Either<DataCRUDFailure, List<EducationPrv>>> instituteApprovedEducations({required DomainUrl institutionDomain, required int paginationLimit}); 

  /// Returns student's education list that are not been approved yet education.
  /// 
  /// ***Only admins of respective institutions can do a successful fetch of education list of respective institutes***.
  Future<Either<DataCRUDFailure, List<EducationPrv>>> institutePendingEducations({required DomainUrl institutionDomain, required int paginationLimit}); 

  /// ***Admin only feature***
  Future<Either<DataCRUDFailure, List<EducationPrv>>> searchByIdEmail({required DomainUrl institutionDomain, required String studentIdOrEmail}); 

  Future<Either<DataCRUDFailure, List<EducationPub>>> fetchUserEducations({required String userId});

  Future<Either<DataCRUDFailure, List<Degree>>> searchDegrees({required String text, required DomainUrl instituteDomain, int? paginationLimit, String? lastDegree });

}