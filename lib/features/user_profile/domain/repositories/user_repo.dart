import 'package:dartz/dartz.dart';


import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../entities/app_user.dart';

abstract interface class UserRepo{

  Future<Either<DataCRUDFailure, AppUser?>> fetchUserInfo();

  Future<Either<DataCRUDFailure, Success>> saveUserInfo(AppUser user);
}