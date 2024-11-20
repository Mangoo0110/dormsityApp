
import '../../../../core/utils/classes/domain.dart';
import '../../domain/entities/degree_field_of_study.dart';
import '../../domain/usecases/admin_approve_education.dart';
import '../../domain/usecases/fetch_user_educations.dart';
import '../../../../init_dependency.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/education_private.dart';
import '../../domain/entities/education_public.dart';
import '../../domain/usecases/institute_pending_educations.dart';
import '../../domain/usecases/search_degree.dart';

class LastFetchedUserEducations{
  final String userId;
  final DateTime lastFetchedAt;//= DateTime.now().subtract(const Duration(hours: 1));
  final List<EducationPub> lastFetchedEducations;

  LastFetchedUserEducations({required this.userId, required this.lastFetchedAt, required this.lastFetchedEducations});

  bool isSameUser({required String userId}){
    return this.userId == userId;
  }

  bool isFetchedLongAgo({required String userId}){
    return DateTime.now().difference(lastFetchedAt).inMinutes > 10;
  }
}


class EducationReadProvider extends ChangeNotifier{

  LastFetchedUserEducations _lastFetchedUserEducations = LastFetchedUserEducations(userId: '', lastFetchedAt: DateTime.now(), lastFetchedEducations: []);

  Future<List<Degree>> searchDegree({required String text, required DomainUrl instituteDomain}) async{
    return serviceLocator<SearchDegree>().call(SearchDegreeParams(text: text, domain: instituteDomain)).then(
      (val) => val.fold(
        (fail){
          Fluttertoast.showToast(msg: "Failed to fetch degrees!");
          return [];
        }, 
        (list) => list
      )
    );
  }


  Future<List<EducationPub>> educationsOfUser({required String userId}) async{
    if(!_lastFetchedUserEducations.isSameUser(userId: userId) || _lastFetchedUserEducations.isFetchedLongAgo(userId: userId)) {
      return serviceLocator<FetchUserEducations>().call(userId).then(
        (val) => val.fold(
          (fail){
            Fluttertoast.showToast(msg: "Failed to fetch user's educations!");
            return [];
          }, 
          (list) {
            _lastFetchedUserEducations = LastFetchedUserEducations(userId: userId, lastFetchedAt: DateTime.now(), lastFetchedEducations: list);
            return list;
          }
        )
      );
    } else {
      return _lastFetchedUserEducations.lastFetchedEducations;
    }
  }

  /// **Only institute admin feature.**
  Future<List<EducationPrv>> institutePendingEducations({required String instituteDomain}) async{

    if(DomainUrl.tryParse(instituteDomain) == null) {
      Fluttertoast.showToast(msg: "Domain does not match domain pattern!");
      return [];
    }

    return serviceLocator<InstitutePendingEducations>().call(DomainUrl.tryParse(instituteDomain)!).then(
      (val) => val.fold(
        (fail){
          Fluttertoast.showToast(msg: "Failed to fetch user's educations!");
          return [];
        }, 
        (list) {
          if(list.isEmpty) Fluttertoast.showToast(msg: "You reached the end of the result");
          return list;
        }
      )
    );
  }

  

}