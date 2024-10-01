
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';

import '../../data/datasources/remote/auth_remote_datasource.dart';

abstract interface class AuthRepo {
  
  bool isUserSignedIn();

  Stream<UserAuth?> get currentUserAuth;
  
  Future<Either<DataCRUDFailure, UserAuth>>signUp({
    required String email,
    required String password,
  });

  Future<Either<DataCRUDFailure, Success>>signIn({
    required String email,
    required String password,
  });

  Future<Either<DataCRUDFailure, Success>>signOut();

}