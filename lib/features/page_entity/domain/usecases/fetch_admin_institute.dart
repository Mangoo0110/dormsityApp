import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/institute_public.dart';
import '../repositories/institute_page_repo.dart';


class FetchAdminInstitute implements AsyncEitherUsecase<InstitutePub, String>{
  final InstituteRepo _instituteRepo;
  FetchAdminInstitute(this._instituteRepo);
  @override
  Future<Either<DataCRUDFailure, InstitutePub>> call(String userId) async{
    return await _instituteRepo.fetchAdminInstitute(userId: userId);
  }

}