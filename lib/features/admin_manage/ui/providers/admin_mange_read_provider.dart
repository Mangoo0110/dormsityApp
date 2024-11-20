
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../core/utils/func/dekhao.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../../../init_dependency.dart';
// import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
// import '../../../hub/domain/usecases/fetch_pages_for_admin.dart';
// import '../../../page_entity/domain/entities/institute_private.dart';
// import '../../../page_entity/domain/usecases/fetch_admin_institute.dart';
// class AdminMangeReadProvider extends ChangeNotifier{
//   DateTime _lastFetchedWas =  DateTime.now().subtract(const Duration(hours: 1));
//   InstitutePrv? _prvInstitute;


//   ///getters
//   InstitutePrv? get institutePrv => _prvInstitute;
  

//   List<DPage> _hubsOfUserAsAdmin = [];

//   List<DPage> get hubsOfUserAsAdmin => _hubsOfUserAsAdmin;



//   Future<void> getUserInstituteAndHubs({required UserAuth userAuth, }) async{
//     int timeLimit = 7;
//     if(DateTime.now().difference(_lastFetchedWas).inMinutes < timeLimit) {
//       dekhao("not over $timeLimit minutes; Its been ${DateTime.now().difference(_lastFetchedWas).inSeconds} seconds.");
//       return ;
//     }
//     dekhao("over $timeLimit minutes");
//     _lastFetchedWas = DateTime.now();
//     await serviceLocator<FetchAdminInstitute>().call(userAuth.id)
//         .then((lr){
//           lr.fold(
//             (l){
              
//             }, (r){
//               _prvInstitute = r; notifyListeners();
              
//             });
//         });

//     await serviceLocator<FetchPagesForAdmin>().call(
//       FetchPagesForAdminParams(userId: userAuth.id,)
//     ).then((lr){
//       return lr.fold(
//         (l){
//           Fluttertoast.showToast(msg: l.message);
//           return [];
//         }, 
//         (r){
//           _hubsOfUserAsAdmin = r; notifyListeners();
//           return r;
//         }
//       );
//     });
//   }
// }