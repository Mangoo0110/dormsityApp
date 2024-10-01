
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


import '../../../../core/usecases/usecases.dart';
import '../../../../init_dependency.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/usecases/fetch_user_info.dart';

class UserProvider extends ChangeNotifier{
  AppUser? _currentUser;

  UserProvider();

  AppUser? get currentAdmin => _currentUser;

  Future<AppUser?> fetchCurrentUser() async{
    return await serviceLocator<FetchUserInfo>().call(NoParams()).then((value) {
      return value.fold((l) {
          Fluttertoast.showToast(msg: l.message);
          return null;
        }, (r) {
          _currentUser = r;
          return r;
        });
    });
  }

  
}