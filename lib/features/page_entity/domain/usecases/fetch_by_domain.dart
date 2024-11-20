import 'package:dartz/dartz.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../core/utils/classes/domain.dart';
import '../entities/institute_public.dart';
import '../repositories/institute_page_repo.dart';

class FetchInstituteByDomain implements AsyncEitherUsecase<InstitutePub, DomainUrl>{
  final InstituteRepo _instituteRepo;
  FetchInstituteByDomain(this._instituteRepo);
  @override
  Future<Either<DataCRUDFailure, InstitutePub>> call(DomainUrl domain) async{
    return await _instituteRepo.fetchByDomain(domain: domain);
  }

}