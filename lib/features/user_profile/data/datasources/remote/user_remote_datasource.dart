import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/utils/constants/data_field_key_names.dart';
import '../../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../models/user_model.dart';

abstract interface class UserInfoRemoteDatasource{
  Future<UserModel?> fetchUserInfo();

  Future<void> saveUserInfo(UserModel user);
}

class UserFirestoreImpl implements UserInfoRemoteDatasource{

  static UserFirestoreImpl? _instance;

  UserFirestoreImpl._();

  static UserFirestoreImpl get instance {
    _instance ??= UserFirestoreImpl._();
    return _instance!;
  }

  CollectionReference<Map<String, dynamic>>? _collectionRef(){ 
    return FirebaseFirestore.instance.collection(kFirestoreUserCollection);
  }

  @override
  Future<UserModel?> fetchUserInfo() async{
    if(_collectionRef() == null || AuthFirebaseImpl.instance.currentUserAuth == null) return null;
    return await _collectionRef()!
    .doc(AuthFirebaseImpl.instance.currentUserAuth!.id).get()
    .then((value) {
      
      try {

        if(value.data() == null){
          throw Exception('Fatal!! Data not found!');
        }
        return UserModel.fromMap(value.data()!);
      } catch (e) {
        throw FormatException("Firestore user data formating failed!", value.data()!.toString());
      }
    });
  }

  @override
  Future<void> saveUserInfo(UserModel admin) async{
    if(_collectionRef() == null || AuthFirebaseImpl.instance.currentUserAuth == null) return;
    return await _collectionRef()!
    .doc(AuthFirebaseImpl.instance.currentUserAuth!.id).set(admin.toMap());
  }

}