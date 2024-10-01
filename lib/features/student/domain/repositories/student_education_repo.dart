import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';

import '../entities/education.dart';
import '../entities/student.dart';

abstract interface class StudentEducationRepo {
  
  Future<Either<DataCRUDFailure, Success>> saveStudent({required Student student});

  Future<Either<DataCRUDFailure, Success>> approveStudent({required Student student});

  Future<Either<DataCRUDFailure, Success>> approveGraduationComplete({required Student student});

  /// Only admins of institution can do a successful fetch of student list.
  Future<Either<DataCRUDFailure, List<Student>>> fetchStudents({required String institutionDomain}); 

  Future<Either<DataCRUDFailure, List<Education>>> fetchUserEducationList({required String userId});
  
}