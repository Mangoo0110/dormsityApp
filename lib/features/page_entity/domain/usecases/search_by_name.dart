import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../entities/institute_public.dart';
import '../repositories/institute_page_repo.dart';

class SearchByName implements AsyncEitherUsecase<List<InstitutePub>, InstituteSearchParams> {
  final InstituteRepo _instituteRepo;
  SearchByName(this._instituteRepo);

  @override
  Future<Either<DataCRUDFailure, List<InstitutePub>>> call(InstituteSearchParams params) async {
    dekhao("_instituteRepo.searchByName(searchText: params.userInput, lastInstituteName: params.lastInstituteName);");
    return await _instituteRepo.searchByName(searchText: params.userInput, lastInstituteName: params.lastInstituteName);
  }
}

class InstituteSearchParams {
  final String userInput;
  final int? loadMore;
  final String? lastInstituteName;

  InstituteSearchParams({
    required this.userInput,
    required this.loadMore,
    required this.lastInstituteName,
  });
}
