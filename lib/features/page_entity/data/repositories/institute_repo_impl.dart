import 'package:dartz/dartz.dart';
import 'package:dormsity/features/page_entity/domain/usecases/update_institute_page_bio.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../../../core/utils/classes/domain.dart';
import '../datasources/remote/remote_institute_datasource.dart';
import '../models/institute_public_model.dart';
import '../../domain/entities/institute_public.dart';
import '../../domain/repositories/institute_page_repo.dart';

class InstituteRepoImpl implements InstituteRepo{

  final RemoteInstituteDatasource _remoteInstituteDatasource;

  InstituteRepoImpl(this._remoteInstituteDatasource);

  @override
  Future<Either<DataCRUDFailure, InstitutePub>> fetchAdminInstitute({required String userId}) async{
    return await asyncTryCatch<InstitutePub>(tryFunc: ()async{
      return await _remoteInstituteDatasource.fetchAdminInstitute(userId: userId);
    });
  }

  @override
  Future<Either<DataCRUDFailure, InstitutePub>> fetchByDomain({required DomainUrl domain}) async{
    return await asyncTryCatch<InstitutePub>(tryFunc: ()async{
      return await _remoteInstituteDatasource.fetchByDomain(domain: domain);
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> saveInstitute({required InstitutePub institute}) async{
    return await asyncTryCatch<Success>(tryFunc: ()async{
      return await _remoteInstituteDatasource.createInstitute(
        institute: InstitutePubModel.fromEntity(institute))
      .then((_) => Success());
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, List<InstitutePub>>> searchByName({required String searchText, int? loadMore, String? lastInstituteName}) async{
    return await asyncTryCatch<List<InstitutePub>>(tryFunc: () async{
      return await _remoteInstituteDatasource.searchByName(searchText: searchText, lastInstituteName: lastInstituteName);
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> addAdmin({required String docId, required String userId}) async{
    return await asyncTryCatch<Success>(tryFunc: () async{
      return await _remoteInstituteDatasource.addAdmin(docId: docId, userId: userId).then((_) => Success());
    });
  }

  @override
  Future<Either<DataCRUDFailure, Success>> updatePageBio({required UpdateInstitutePageBioParams institute}) {
    // TODO: implement updatePageBio
    throw UnimplementedError();
  }
  
  
}