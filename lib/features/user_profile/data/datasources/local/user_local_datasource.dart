
import 'package:hive/hive.dart';

import '../../../../../core/utils/func/dekhao.dart';

import '../../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../models/admin_sync_model.dart';

abstract interface class UserInfoLocalDatasource{
  Future<UserSync?> fetchAdminInfo();

  Future<void> saveAdminInfo(UserSync adminSync);
}

class UserHiveImpl implements UserInfoLocalDatasource{

  static UserHiveImpl? _instance;

  UserHiveImpl._(){
    if(_box == null){
      _openBox();
    }
  }

  static UserHiveImpl get instance {
    _instance ??= UserHiveImpl._();
    return _instance!;
  }

  Box<dynamic>? _box;

  final _boxName = 'UserHive';

  Future<void> _openBox() async{
    _box ??= await Hive.openBox(_boxName);
    return;
  }

  @override
  Future<UserSync?> fetchAdminInfo() async{
    if(AuthFirebaseImpl.instance.currentUserAuth == null) return null;
    return await _openBox()
    .then((value) {
      
      try {
        if(_box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id).toString() == "null"){
          throw Exception('Fatal!! Data not found!');
        }
        return UserSync.fromMap(_box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id));
      } catch (e) {
        dekhao("Failed! ${'\n\n'} ${_box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id).toString()} failed. ${'\n\n'} Failed.");
        throw FormatException("Hive admin data formatting failed!", _box!.get(AuthFirebaseImpl.instance.currentUserAuth!.id).toString());
      }
    });
  }

  @override
  Future<void> saveAdminInfo(UserSync adminSync) async{
    if(AuthFirebaseImpl.instance.currentUserAuth == null) return;
    return await _openBox().then((value) async{
      return await _box!.put(adminSync.admin.id, adminSync.toMap());
    });
  }

}