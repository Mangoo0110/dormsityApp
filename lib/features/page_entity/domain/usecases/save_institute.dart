import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/institute_public.dart';
import '../repositories/institute_page_repo.dart';


class SaveInstitute implements AsyncEitherUsecase<Success, InstitutePub>{
  final InstituteRepo _instituteRepo;
  SaveInstitute(this._instituteRepo);
  @override
  Future<Either<DataCRUDFailure, Success>> call(InstitutePub institute) async{
    return await _instituteRepo.saveInstitute(institute: institute);
  }

}