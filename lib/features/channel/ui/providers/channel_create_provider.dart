
import '../../../../core/utils/enums/page_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../page_entity/domain/entities/page_public.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../init_dependency.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/create_channel.dart';




class ChannelCreateProvider extends ChangeNotifier {
  late CreateChannelParams _createChannelParams;

  SaveStatus _saveStatus = SaveStatus.canNotSave;


  // getters
  SaveStatus get saveStatus => _saveStatus;
  CreateChannelParams get createChannelParams => _createChannelParams;

  ChannelCreateProvider({required UserAuth currentUserAuth, required PagePublic pagePublic}) {
    _saveStatus = SaveStatus.canNotSave;
    _createChannelParams = CreateChannelParams(currentUserAuth: currentUserAuth, pagePublic: pagePublic);
  }

  void checkIfCanSave() {
    bool canCreate = _createChannelParams.canCreate();
    dekhao("Can create $canCreate");
    // If can not create logic.
    if(!canCreate && _saveStatus != SaveStatus.canNotSave) {
        _saveStatus = SaveStatus.canNotSave; notifyListeners();
    }

    // If can create logic.
    if(canCreate && _saveStatus != SaveStatus.canSave) {
        _saveStatus = SaveStatus.canSave; notifyListeners();
    }
  }

  /// Returns the channelName from the function parameter if applicable or returns previous channelName.
  String setChannelName(String channelName) {
    _createChannelParams.channelName = channelName; notifyListeners();
    checkIfCanSave();
    return channelName;
  }

  void setUnsetPublic(bool isPublic){
    _createChannelParams.public = isPublic; notifyListeners();
    checkIfCanSave();
  }

  void setChannelType(ChannelType channelType){
    _createChannelParams.channelType = channelType; notifyListeners();
    checkIfCanSave();
  }

  Future<void> createChannel() async{
    _saveStatus = SaveStatus.saving; notifyListeners();

    return await serviceLocator<CreateChannel>().call(_createChannelParams).then((lr) {
      return lr.fold(
        (l){
          _saveStatus = SaveStatus.failed; notifyListeners();
        }, (r) {
          _createChannelParams = _createChannelParams;
          _saveStatus = SaveStatus.saved; notifyListeners();
        }
      );
    });
  }

  
}
