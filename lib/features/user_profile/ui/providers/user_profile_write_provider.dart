


import 'package:dormsity/features/user_profile/data/models/user_prv_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../domain/entities/user_prv.dart';
import '../../domain/usecases/save_user_info.dart';

enum WriteType {creating, updating}

class UserProfileWriteProvider extends ChangeNotifier{ 
  WriteType _writeType = WriteType.creating;
  final UserPrv? _oldUserInfo;

  late UserPrv _newUserInfo;

  bool _canSave = false;

  UserProfileWriteProvider(this._oldUserInfo, UserAuth userAuth,){
    if(_oldUserInfo != null) {
      _newUserInfo = UserPrvModel.fromEntity(_oldUserInfo);
      _writeType = WriteType.updating;
    } else {
      _writeType = WriteType.creating;
      _newUserInfo = UserPrv(
        docId: userAuth.id, 
        email: userAuth.email, 
        fullName: '', 
        gender: null,
        birthdate: null,
        joinedAt: DateTime.now(), 
        imageUrl: userAuth.id, 
        about: '', country: '', contactNo: '');
    }
  }

  void init(UserPrv? oldUserInfo, UserAuth userAuth) {
    if(_oldUserInfo != null) {
      _newUserInfo = _oldUserInfo;
      _writeType = WriteType.updating;
    } else {
      _writeType = WriteType.creating;
      _newUserInfo = UserPrv(
        docId: userAuth.id, 
        email: userAuth.email, 
        fullName: '', 
        gender: null,
        birthdate: null,
        joinedAt: DateTime.now(), 
        imageUrl: userAuth.id, 
        about: '', country: '', contactNo: '');
    }
  }

  //getters

  WriteType get writeType => _writeType;

  bool get canSave => _canSave;

  void checkIfCanSave(){
    if(true){
      dekhao("can save");
      if(!_canSave){
        _canSave = true; notifyListeners();
      }
    }
  }

  void setEmail(String email){
    _newUserInfo.email = email.trim();
    checkIfCanSave();
  }

  void setFullName(String fullName){
    _newUserInfo.fullName = fullName.trim();
    dekhao(fullName);
    checkIfCanSave();
  }

  void setProfession(String about){
    _newUserInfo.about = about.trim();
    checkIfCanSave();
  }

  void setImageUrl(String imageUrl){
    _newUserInfo.imageUrl = imageUrl.trim();
    checkIfCanSave();
  }

  void setGender(Gender gender){
    _newUserInfo.gender = gender;
    checkIfCanSave();
  }

  DateTime? setBirthdate(DateTime birthdate){
    _newUserInfo.birthdate = birthdate;
    checkIfCanSave();
    return birthdate;
  }

  Future<void> saveUserInfo({
    required VoidCallback onDone
  }) async{
    if(!_canSave) {
      onDone();
      return;
    }
    await serviceLocator<SaveUserInfo>().call(_newUserInfo).then((value) {
      value.fold((l) {
        Fluttertoast.showToast(msg: "Could not save user info!. ${l.message}");
      }, (r) async{
        Fluttertoast.showToast(msg: "User info is saved.");
      });
      
    });
    onDone();
  }
}