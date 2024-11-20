import 'package:dartz/dartz.dart';
import '../entities/education_public.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/education_repo.dart';


class FetchUserEducations implements AsyncEitherUsecase<List<EducationPub>, String>{
  final EducationRepo _studentEducationRepo;

  FetchUserEducations(this._studentEducationRepo);

  @override
  Future<Either<DataCRUDFailure, List<EducationPub>>> call(String params) async{
    return await _studentEducationRepo.fetchUserEducations(userId: params);
  }
  
}