import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/student_education_repo.dart';

import '../entities/student.dart';

class SaveStudent implements AsyncEitherUsecase<Success, Student>{
  final StudentEducationRepo _studentEducationRepo;

  SaveStudent(this._studentEducationRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(Student params) async{
    return await _studentEducationRepo.saveStudent(student: params);
  }
  
}