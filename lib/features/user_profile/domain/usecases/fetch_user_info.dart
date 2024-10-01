import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/app_user.dart';
import '../repositories/user_repo.dart';

class FetchUserInfo implements AsyncEitherUsecase<AppUser?, NoParams>{

  final UserRepo _userRepo;

  FetchUserInfo(this._userRepo);

  @override
  Future<Either<DataCRUDFailure, AppUser?>> call(NoParams params) async{
    return await _userRepo.fetchUserInfo();
  }

}