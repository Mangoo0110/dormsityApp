

import 'package:dartz/dartz.dart';
import 'package:dormsity/features/page_entity/data/models/page_private_model.dart';
import '../../data/models/page_public_model.dart';
import '../entities/institute_public.dart';
import '../entities/page_private.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/institute_page_repo.dart';

class UpdateInstitutePageBio implements AsyncEitherUsecase<Success, UpdateInstitutePageBioParams>{
  final InstituteRepo _instituteRepo;
  UpdateInstitutePageBio(this._instituteRepo);
  @override
  Future<Either<DataCRUDFailure, Success>> call(UpdateInstitutePageBioParams institute) async{
    return await _instituteRepo.updatePageBio(institute: institute);
  }

}

class UpdateInstitutePageBioParams {
  final String docId;
  String pageName;
  String description;
  LocationDetail location;
  final InstitutePub _institutePub;
  
  UpdateInstitutePageBioParams(
    this._institutePub 
  ): docId = _institutePub.docId,
    pageName = _institutePub.pageName,
    description = _institutePub.description,
    location = _institutePub.location;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pageName': pageName,
      'description': description,
      'location': LocationDetailsModel.fromEntity(location).toMap()
    };
  }

  bool isBioChanged(){
    return pageName != _institutePub.pageName
      || description != _institutePub.description
      || location != _institutePub.location;
  }

}
