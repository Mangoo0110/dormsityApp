import 'package:dartz/dartz.dart';
import 'package:dormsity/core/api_handler/failure.dart';
import 'package:dormsity/core/api_handler/success.dart';
import 'package:dormsity/core/usecases/usecases.dart';

import '../repositories/institute_page_repo.dart';

class AddAdmin implements AsyncEitherUsecase<Success, AddInstitutePageAdminParams>{

  final InstituteRepo _instituteRepo;
  AddAdmin(this._instituteRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(AddInstitutePageAdminParams params) async{
    return await _instituteRepo.addAdmin(docId: params.docId, userId: params.userId);
  }

}

class AddInstitutePageAdminParams{
  final String docId;
  final String userId;

  AddInstitutePageAdminParams({required this.docId, required this.userId});
}