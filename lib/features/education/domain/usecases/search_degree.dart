import 'package:dartz/dartz.dart';
import '../../../../core/utils/classes/domain.dart';
import '../entities/degree_field_of_study.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/education_repo.dart';


class SearchDegree implements AsyncEitherUsecase< List<Degree>, SearchDegreeParams>{
  final EducationRepo _studentEducationRepo;

  SearchDegree(this._studentEducationRepo);

  @override
  Future<Either<DataCRUDFailure,  List<Degree>>> call(SearchDegreeParams params) async{
    return await _studentEducationRepo.searchDegrees(text: params.text, instituteDomain: params.domain);
  }
  
}

class SearchDegreeParams {
  /// Degree prefix that you are searching.
  final String text;
  /// Domain name of the institute.
  final DomainUrl domain;

  SearchDegreeParams({required this.text, required this.domain});
}