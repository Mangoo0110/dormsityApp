import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/app_user.dart';
import '../repositories/user_repo.dart';

class SaveUserInfo implements AsyncEitherUsecase<Success, AppUser>{

  final UserRepo _userRepo;

  SaveUserInfo(this._userRepo);

  @override
  Future<Either<DataCRUDFailure, Success>> call(AppUser params) async{
    return await _userRepo.saveUserInfo(params);
  }

}