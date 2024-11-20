import 'dart:collection';

import '../../../../core/utils/classes/domain.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../domain/usecases/fetch_admin_institute.dart';
import '../../../../init_dependency.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/institute_public.dart';
import '../../domain/usecases/fetch_by_domain.dart';
import '../../domain/usecases/search_by_name.dart';

class InstitutePageReadProvider extends ChangeNotifier{

  List<InstitutePub> _searchedInstituteList = [];
  String _searchedName = '';

  void searchClear() {
    _searchedInstituteList = []; _searchedName = '';
  }


  //getters

  UnmodifiableListView<InstitutePub> get searchedInstituteList => UnmodifiableListView<InstitutePub>(_searchedInstituteList);

  Future<InstitutePub?> fetchByDomain(String domain) async{
    if(DomainUrl.tryParse(domain) == null) return null;
    return serviceLocator<FetchInstituteByDomain>().call(DomainUrl.tryParse(domain)!)
        .then((lr){
          return lr.fold(
            (l){
              return null;
            }, (r){
              return r;
            });
        });
  }

  Future<void> searchByName(String userInput) async{

    _searchedInstituteList.removeWhere((item) => !item.pageName.trim().toLowerCase().startsWith(userInput.trim().toLowerCase()));

    if(!_searchedName.toLowerCase().startsWith(userInput.toLowerCase()) || userInput.trim().isEmpty) {
      _searchedName = userInput.trim(); _searchedInstituteList = [];
    }
    return serviceLocator<SearchByName>().call(InstituteSearchParams(userInput: userInput, loadMore: null, lastInstituteName: _searchedInstituteList.isEmpty ? null : _searchedInstituteList.last.pageName))
        .then((lr){
          return lr.fold(
            (l){
              
            }, (r){
              if(_searchedName == userInput) {
                _searchedInstituteList.addAll(r); notifyListeners();
                if(r.isNotEmpty) _searchedName = r.last.pageName;
              }
            });
        });
  }

  Future<InstitutePub?> fetchAdminInstitute(UserAuth userAuth) async{
    
    return serviceLocator<FetchAdminInstitute>().call(userAuth.id)
        .then((lr){
          return lr.fold(
            (l){
              return null;
            }, (r){
              return r;
            });
        });
  }
}