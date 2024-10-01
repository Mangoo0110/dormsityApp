// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../../core/api_handler/failure.dart';
import '../../../../../core/api_handler/success.dart';
import '../../../../../core/usecases/usecases.dart';
import '../entities/complain.dart';
import '../repositories/complain_repo.dart';


class DeleteComplain implements AsyncEitherUsecase<Success, Complain> {

  final ComplainRepo _complainRepo;

  DeleteComplain(
    this._complainRepo,
  );

  @override
  Future<Either<DataCRUDFailure, Success>> call(Complain params) async{
    return await _complainRepo.deleteComplain(complain: params);
  }

}