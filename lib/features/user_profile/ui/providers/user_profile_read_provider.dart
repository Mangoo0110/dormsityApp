
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../../init_dependency.dart';
import '../../domain/entities/user_prv.dart';
import '../../domain/entities/user_pub.dart';
import '../../domain/usecases/fetch_current_user_info.dart';
import '../../domain/usecases/fetch_user_info.dart';

class UserProfileReadProvider extends ChangeNotifier{
  UserPrv? _currentUser;

  UserProfileReadProvider();

  UserPrv? get currentUser => _currentUser;

  Future<UserPrv?> fetchCurrentUser({bool? forceFetch}) async{
    return await serviceLocator<FetchCurrentUserInfo>().call(forceFetch).then((value) {
      return value.fold((l) {
          Fluttertoast.showToast(msg: l.message);
          return null;
        }, (r) {
          _currentUser = r; notifyListeners();
          return r;
        });
    });
  }


  Future<UserPub?> fetchUserInfo({required String userId}) async{
    return await serviceLocator<FetchUserInfo>().call(userId).then((value) {
      return value.fold((l) {
          Fluttertoast.showToast(msg: l.message);
          return null;
        }, (r) {
          return r;
        });
    });
  }

  
}