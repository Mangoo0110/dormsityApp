import 'core/utils/func/dekhao.dart';
import 'features/channel/domain/usecases/fetch_admin_channel_id_list.dart';

import 'features/channel/domain/usecases/fetch_following_channel_id_list.dart';
import 'init_dependency.dart';
import 'package:flutter/material.dart';

import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';

class UserAppDataProvider extends ChangeNotifier{
  UserAuth? _userAuth;
  List<String> adminChannelIdList = [];
  List<String> followingChannelIdList = [];
  void init({required UserAuth userAuth}){
    if(_userAuth != userAuth) {
      _userAuth = userAuth;
    }
    _getAdminChannelIdList(userAuth);
    _getFollowingChannelIdList(userAuth);
  }

  void update({required UserAuth userAuth}){
    init(userAuth: userAuth);
  }

  Future<void> _getAdminChannelIdList(UserAuth userAuth) async{
    await serviceLocator<FetchAdminChannelIdList>().call(userAuth).then((lr){
      lr.fold(
        (l){

        }, (r){
          dekhao("User's admin of channels id list is ${r.map((e) => dekhao(e))}");
          adminChannelIdList = r; notifyListeners();
        });
    });
  }

  Future<void> _getFollowingChannelIdList(UserAuth userAuth) async{
    await serviceLocator<FetchFollowingChannelIdList>().call(userAuth).then((lr){
      lr.fold(
        (l){

        }, (r){
          followingChannelIdList = r; notifyListeners();
          dekhao("User's following channels id list is ${r.map((e) => dekhao(e))}");
        });
    });
  }
}