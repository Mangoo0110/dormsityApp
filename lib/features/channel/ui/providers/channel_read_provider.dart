// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../init_dependency.dart';
// import '../../domain/entities/page.dart';
// import '../../domain/usecases/fetch_pages_for_admin.dart';

// class PageReadProvider {

//   List<DPage> _pagesOfUserAsAdmin = [];

//   List<DPage> get pagesOfUserAsAdmin => _pagesOfUserAsAdmin;


//   init(String currentUserId) async{
//     if(_pagesOfUserAsAdmin.isEmpty) {
//       await getChannelsOfUserAsAdmin(userId: currentUserId);
//     }
//   }

//   Future<List<DPage>> getChannelsOfUserAsAdmin({required String userId, int? paginationLimit,  DPage? lastFetchedPage}) async{
//     return await serviceLocator<FetchPagesForAdmin>().call(
//       FetchPagesForAdminParams(userId: userId, paginationLimit: paginationLimit, lastFetchedPage: lastFetchedPage)
//     ).then((lr){
//       return lr.fold(
//         (l){
//           Fluttertoast.showToast(msg: l.message);
//           return [];
//         }, 
//         (r){
//           _pagesOfUserAsAdmin = r;
//           return r;
//         }
//       );
//     });
//   }

// }