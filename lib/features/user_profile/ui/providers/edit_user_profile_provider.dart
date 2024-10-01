import 'dart:typed_data';



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../../image/domain/entities/image.dart';
import '../../../image/domain/usecases/save_image.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/save_user_info.dart';

class EditUserProfileProvider extends ChangeNotifier{
  final AppUser? _prevAdminInfo;

  late AppUser _afterEditAdminInfo;

  Uint8List? _profilePic;

  bool _canSave = false;

  bool _profilePicNeedSave = false;

  EditUserProfileProvider(this._prevAdminInfo, UserAuth adminAuth, this._profilePic){
    dekhao(" profile pic null ?");
    if(_prevAdminInfo != null) {
      _afterEditAdminInfo = _prevAdminInfo;
    } else {
      _afterEditAdminInfo = AppUser(
        id: adminAuth.id, 
        email: adminAuth.email, 
        fullName: '', 
        joinedAt: DateTime.now(), 
        imageId: adminAuth.id, 
        profession: '', country: '', contactNo: '');
    }
    dekhao("_afterEditAdminInfo.imageId ${_afterEditAdminInfo.imageId}");
  }

  bool get canSave => _canSave;

  Uint8List? get profilePic => _profilePic;

  void checkIfCanSave(){
    if(true){
      dekhao("can save");
      if(!_canSave){
        _canSave = true; notifyListeners();
      }
    }
  }

  void setEmail(String email){
    _afterEditAdminInfo.email = email;
    checkIfCanSave();
  }

  void setFullName(String fullName){
    _afterEditAdminInfo.fullName = fullName;
    dekhao(fullName);
    checkIfCanSave();
  }

  void setProfession(String profession){
    _afterEditAdminInfo.profession = profession;
    checkIfCanSave();
  }

  void setProfilePic(Uint8List image){
    _profilePicNeedSave = true;
    _profilePic = image;
    _canSave = true;
    _profilePicNeedSave = true;
    notifyListeners();
  }

  Future<void> saveAdminInfo({
    required VoidCallback onDone
  }) async{
    if(!_canSave) {
      onDone();
      return;
    }
    if(_afterEditAdminInfo == _prevAdminInfo && _profilePicNeedSave && _profilePic != null){
      dekhao("saving only image.");
      await serviceLocator<SaveImage>().call(ImageX(id: _afterEditAdminInfo.id, image: _profilePic!)).then((value) => onDone());
      return;
    }
    await serviceLocator<SaveUserInfo>().call(_afterEditAdminInfo).then((value) {
      
      value.fold((l) {
        Fluttertoast.showToast(msg: "Could not save admin info!. ${l.message}");
      }, (r) async{
        Fluttertoast.showToast(msg: "Admin info is saved.");
        if(_profilePicNeedSave && _profilePic != null){
          await serviceLocator<SaveImage>().call(ImageX(id: _afterEditAdminInfo.imageId, image: _profilePic!)).then((value) {
            value.fold((l) => null, (r) => onDone());
          });
        }
        
      });
      
    });
    onDone();
  }
}