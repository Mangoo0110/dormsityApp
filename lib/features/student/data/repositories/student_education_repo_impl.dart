import 'package:dartz/dartz.dart';

import 'package:dormsity/core/api_handler/failure.dart';

import 'package:dormsity/core/api_handler/success.dart';
import 'package:dormsity/core/api_handler/trycatch.dart';
import 'package:dormsity/features/student/data/datasources/remote/student_education_remote_datasource.dart';
import 'package:dormsity/features/student/data/models/student_model.dart';

import 'package:dormsity/features/student/domain/entities/education.dart';

import 'package:dormsity/features/student/domain/entities/student.dart';

import '../../domain/repositories/student_education_repo.dart';

class StudentEducationRepoImpl implements StudentEducationRepo {
  final StudentEducationRemoteDataSource _studentEducationRemoteDataSource;

  StudentEducationRepoImpl(this._studentEducationRemoteDataSource);

  @override
  Future<Either<DataCRUDFailure, Success>> approveGraduationComplete({required Student student}) async {
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _studentEducationRemoteDataSource
          .approveGraduationComplete(
              student: StudentModel.fromEntity(student: student))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> approveStudent({required Student student}) async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _studentEducationRemoteDataSource
          .approveStudent(
              student: StudentModel.fromEntity(student: student))
          .then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<Student>>> fetchStudents({required String institutionDomain}) async{
    return await asyncTryCatch<List<Student>>(tryFunc: () async {
      return await _studentEducationRemoteDataSource
          .fetchStudents(institutionDomain: institutionDomain);
    });
  }

  @override
  Future<Either<DataCRUDFailure, List<Education>>> fetchUserEducationList({required String userId}) async{
    return await asyncTryCatch<List<Education>>(tryFunc: () async {
      return await _studentEducationRemoteDataSource
          .fetchUserEducationList(userId: userId);
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> saveStudent({required Student student}) async{
    return await asyncTryCatch<Success>(tryFunc: () async {
      return await _studentEducationRemoteDataSource
          .saveStudent(
              student: StudentModel.fromEntity(student: student))
          .then((_) => Success());
    });
  }
}