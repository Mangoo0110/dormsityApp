
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api_handler/failure.dart';
import '../../../../core/api_handler/success.dart';
import '../../../../core/api_handler/trycatch.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/repositories/user_repo.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../models/user_model.dart';
import '../models/admin_sync_model.dart';

class UserRepoImpl implements UserRepo{

  final UserInfoRemoteDatasource _adminRemoteDatasource;
  final UserInfoLocalDatasource _adminLocalDatasource;

  UserRepoImpl(this._adminRemoteDatasource, this._adminLocalDatasource);
  
  @override
  Future<Either<DataCRUDFailure, AppUser?>> fetchUserInfo() async{
    return await _remotefetchAdminInfo().then((value) async{
      return await value.fold(
        (l) async{
          return await _localfetchAdminInfo();
        }, (admin) async{
          if(admin != null) {
            await _saveAdminInfoAtLocal(UserSync(type: DocumentChangeType.added, admin: UserModel.fromEntity(admin), isSynced: true));
          }
          return Right(admin);
        });
    });
  }

  Future<Either<DataCRUDFailure, AppUser?>> _remotefetchAdminInfo() async{
    return await asyncTryCatch<AppUser?>(tryFunc: ()async{
      return await _adminRemoteDatasource.fetchUserInfo();
    });
  }

  Future<Either<DataCRUDFailure, AppUser?>> _localfetchAdminInfo() async{
    return await asyncTryCatch<AppUser?>(tryFunc: ()async{
      return await _adminLocalDatasource.fetchAdminInfo().then((value) {
        if(value == null) return null;
        return value.admin;
      });
    });
  }
  
  @override
  Future<Either<DataCRUDFailure, Success>> saveUserInfo(AppUser admin) async{
    return _saveAdminInfoAtRemote(admin).then((value) {
      return value.fold(
        (l) async{
          return await _saveAdminInfoAtLocal(UserSync(type: DocumentChangeType.added, admin: UserModel.fromEntity(admin), isSynced: false));
        }, (r)  async{
          return await _saveAdminInfoAtLocal(UserSync(type: DocumentChangeType.added, admin: UserModel.fromEntity(admin), isSynced: true));
        });
    });
  }
  
  Future<Either<DataCRUDFailure, Success>> _saveAdminInfoAtLocal(UserSync adminSync) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return await _adminLocalDatasource.saveAdminInfo(adminSync).then((value) => Success());
    });
  }

  Future<Either<DataCRUDFailure, Success>> _saveAdminInfoAtRemote(AppUser admin) async{
    return asyncTryCatch<Success>(tryFunc: () async{
      return await _adminRemoteDatasource.saveUserInfo(UserModel.fromEntity(admin)).then((value) => Success());
    });
  }

}