import 'package:dartz/dartz.dart';
import '../entities/institute_public.dart';
import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';

import '../../../../core/utils/classes/domain.dart';
import '../usecases/update_institute_page_bio.dart';

abstract interface class InstituteRepo {

  Future<Either<DataCRUDFailure, Success>> saveInstitute({required InstitutePub institute});

  Future<Either<DataCRUDFailure, Success>> updatePageBio({required UpdateInstitutePageBioParams institute});

  Future<Either<DataCRUDFailure, InstitutePub>> fetchByDomain({required DomainUrl domain});

  Future<Either<DataCRUDFailure, InstitutePub>> fetchAdminInstitute({required String userId});

  Future<Either<DataCRUDFailure, Success>> addAdmin({required String docId, required String userId});

  Future<Either<DataCRUDFailure, List<InstitutePub>>> searchByName({required String searchText, int? loadMore, String? lastInstituteName});

}