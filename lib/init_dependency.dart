import 'package:cloud_firestore/cloud_firestore.dart';
import 'features/channel/domain/usecases/unfollow_channel.dart';
import 'features/post/domain/usecases/news/downvote_news_post.dart';
import 'features/post/domain/usecases/news/fetch_all_news_of_channel.dart';
import 'features/post/domain/usecases/news/fetch_news_feed_for_home_screen.dart';
import 'features/post/domain/usecases/news/fetch_news_post.dart';
import 'features/post/domain/usecases/news/upvote_news.dart';
import 'features/channel/data/datasources/remote_channel_datasource.dart';
import 'features/channel/data/repositories/channel_repo_impl.dart';
import 'features/channel/domain/repositories/channel_repo.dart';
import 'features/channel/domain/usecases/add_channel_admin.dart';
import 'features/channel/domain/usecases/create_channel.dart';
import 'features/channel/domain/usecases/fetch_admin_channel_id_list.dart';
import 'features/channel/domain/usecases/fetch_channel.dart';
import 'features/channel/domain/usecases/fetch_following_channel_id_list.dart';
import 'features/channel/domain/usecases/follow_channel.dart';
import 'features/education/domain/usecases/disapprove_education.dart';
import 'features/education/domain/usecases/institute_pending_educations.dart';
import 'features/education/domain/usecases/search_degree.dart';
import 'features/image/domain/usecases/save_image_with_reference_path.dart';
import 'features/page_entity/domain/usecases/add_admin.dart';
import 'features/page_entity/domain/usecases/fetch_admin_institute.dart';
import 'features/page_entity/domain/usecases/fetch_by_domain.dart';
import 'features/page_entity/domain/usecases/save_institute.dart';
import 'features/page_entity/data/datasources/remote/remote_institute_datasource.dart';
import 'features/page_entity/data/repositories/institute_repo_impl.dart';
import '../../features/education/data/datasources/remote/education_remote_datasource.dart';
import 'features/education/data/repositories/education_repo_impl.dart';
import '../../features/education/domain/usecases/admin_approve_gradution_complete.dart';
import 'features/education/domain/usecases/admin_approve_education.dart';
import 'features/education/domain/usecases/fetch_user_educations.dart';
import 'features/education/domain/usecases/institute_approved_educations.dart';
import 'features/education/domain/usecases/create_education.dart';
import '../../features/work_role/data/datasources/remote/work_role_remote_datasource.dart';
import '../../features/work_role/data/repositories/work_repo_impl.dart';
import '../../features/work_role/domain/usecases/approve_work_role.dart';
import '../../features/work_role/domain/usecases/approve_work_role_complete.dart';
import '../../features/work_role/domain/usecases/fetch_institute_work_roles_pub.dart';
import '../../features/work_role/domain/usecases/fetch_user_work_roles.dart';
import '../../features/work_role/domain/usecases/save_work_role.dart';
import '../features/auth/domain/usecases/get_current_user.dart';
import '../features/auth/domain/usecases/user_is_logged_in.dart';
import '../features/auth/domain/usecases/user_signin.dart';
import 'features/image/domain/usecases/save_image_with_url.dart';
import '../firebase_options.dart';
import '../features/user_profile/data/datasources/local/user_local_datasource.dart';
import '../features/user_profile/data/datasources/remote/user_remote_datasource.dart';
import '../features/user_profile/data/repositories/user_repo_impl.dart';
import 'features/post/data/datasources/remote/news_post_remote_datasource.dart';
import 'features/post/data/repositories/news_post_repo_impl.dart';
import 'features/post/domain/repositories/news_post_repo.dart';
import 'features/post/domain/usecases/news/create_news_post.dart';
import 'features/user_profile/domain/usecases/fetch_current_user_info.dart';
import '../features/user_profile/domain/usecases/save_user_info.dart';
import '../features/auth/data/datasources/remote/auth_remote_datasource.dart';
import '../features/auth/data/repositories/auth_repo_impl.dart';
import '../features/auth/domain/usecases/user_signup.dart';
import '../features/image/data/datasources/firebase/image_firebase_datasource.dart';
import '../features/image/data/repositories/image_repo_impl.dart';
import '../features/image/domain/usecases/delete_image.dart';
import '../features/image/domain/usecases/fetch_image.dart';


import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'features/page_entity/domain/usecases/search_by_name.dart';
import 'features/user_profile/domain/usecases/fetch_user_info.dart';

final serviceLocator = GetIt.instance;

  //::: Datasources [register singletone]

  //::: Repo [register factory]

  //::: Usecases

Future<void> initDependencies()async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) async{
    await FirebaseAppCheck.instance.activate(
    
      webProvider: ReCaptchaV3Provider("DormsityAppAnik"),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest
    );
  });
  
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  serviceLocator.registerSingleton(()=> firebaseFirestore);
  serviceLocator.registerSingleton(()=> FirebaseAuth.instance);
  _authService();
  _imageService();
  _userInfoService();
  _educationService();
  _workRoleService();
  _institutePageService();
  _channelService();
  _newsPostService();
}


void _imageService() {
  //::: Remote Datasource [register singletone]
  serviceLocator.registerLazySingleton(() => ImageFirebaseStorageImpl.instance);

  //::: Local Datasource [register singletone]

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => ImageRepoImpl(serviceLocator<ImageFirebaseStorageImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => DeleteImage(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchImage(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SaveImageWithUrl(serviceLocator<ImageRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SaveImageWithReferencePath(serviceLocator<ImageRepoImpl>()));
  
}


void _authService(){  
  
  serviceLocator.registerLazySingleton(() => AuthFirebaseImpl.instance);

  serviceLocator.registerFactory(() => AuthRepoImpl(serviceLocator<AuthFirebaseImpl>()));

  // usecases

  serviceLocator.registerLazySingleton(() => UserSignIn(serviceLocator<AuthRepoImpl>()));

  serviceLocator.registerLazySingleton(() => UserSignUp(serviceLocator<AuthRepoImpl>()));

  serviceLocator.registerLazySingleton(() => GetCurrentUserAuth(serviceLocator<AuthRepoImpl>()));

  serviceLocator.registerLazySingleton(() => IsUserSignedIn(serviceLocator<AuthRepoImpl>()));

}

void _userInfoService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton(() => UserFirestoreImpl.instance);
  serviceLocator.registerLazySingleton(() => UserHiveImpl.instance);

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => UserRepoImpl(serviceLocator<UserFirestoreImpl>(), serviceLocator<UserHiveImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => SaveUserInfo(serviceLocator<UserRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchCurrentUserInfo(serviceLocator<UserRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchUserInfo(serviceLocator<UserRepoImpl>()));
}


void _educationService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton(() => EducationFirebaseImpl.instance);

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => EducationRepoImpl(serviceLocator<EducationFirebaseImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => CreateEducation(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchUserEducations(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => InstituteApprovedEducations(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => InstitutePendingEducations(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => ApproveEducation(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => DisApproveEducation(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => ApproveGraduation(serviceLocator<EducationRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SearchDegree(serviceLocator<EducationRepoImpl>()));
}

void _workRoleService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton(() => WorkRoleFirebaseImpl.instance);

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => WorkRoleRepoImpl(serviceLocator<WorkRoleFirebaseImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => SaveWorkRole(serviceLocator<WorkRoleRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchUserWorkRoles(serviceLocator<WorkRoleRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchInstituteWorkRolesPub(serviceLocator<WorkRoleRepoImpl>()));
  serviceLocator.registerLazySingleton(() => ApproveWorkRole(serviceLocator<WorkRoleRepoImpl>()));
  serviceLocator.registerLazySingleton(() => ApproveWorkRoleComplete(serviceLocator<WorkRoleRepoImpl>()));
}

void _institutePageService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton(() => InstituteFirebaseImpl());

  //::: Repo [register factory]
  serviceLocator.registerFactory(() => InstituteRepoImpl(serviceLocator<InstituteFirebaseImpl>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => SaveInstitute(serviceLocator<InstituteRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchAdminInstitute(serviceLocator<InstituteRepoImpl>()));
  serviceLocator.registerLazySingleton(() => FetchInstituteByDomain(serviceLocator<InstituteRepoImpl>()));
  serviceLocator.registerLazySingleton(() => SearchByName(serviceLocator<InstituteRepoImpl>()));
  serviceLocator.registerLazySingleton(() => AddAdmin(serviceLocator<InstituteRepoImpl>()));
} 

void _channelService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton<RemoteChannelDatasource>(() => ChannelFirebaseImpl());

  //::: Repo [register factory]
  serviceLocator.registerFactory<ChannelRepo>(() => ChannelRepoImpl(serviceLocator<RemoteChannelDatasource>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => CreateChannel(serviceLocator<ChannelRepo>()));
  serviceLocator.registerLazySingleton(() => AddChannelAdmin(serviceLocator<ChannelRepo>()));
  serviceLocator.registerLazySingleton(() => FollowChannel(serviceLocator<ChannelRepo>()));
  serviceLocator.registerLazySingleton(() => UnFollowChannel(serviceLocator<ChannelRepo>()));
  serviceLocator.registerLazySingleton(() => FetchAdminChannelIdList(serviceLocator<ChannelRepo>()));
  serviceLocator.registerLazySingleton(() => FetchFollowingChannelIdList(serviceLocator<ChannelRepo>()));
  serviceLocator.registerLazySingleton(() => FetchChannel(serviceLocator<ChannelRepo>()));
  
} 

void _newsPostService(){

  //::: Datasources [register singletone]  
  serviceLocator.registerLazySingleton<NewsPostRemoteDatasource>(() => NewsFirebaseImpl());

  //::: Repo [register factory]
  serviceLocator.registerFactory<NewsPostRepo>(() => NewsPostRepoImpl(serviceLocator<NewsPostRemoteDatasource>()));

  //::: Usecases
  serviceLocator.registerLazySingleton(() => CreateNewsPost(serviceLocator<NewsPostRepo>()));
  serviceLocator.registerLazySingleton(() => DownvoteNewsPost(serviceLocator<NewsPostRepo>()));
  serviceLocator.registerLazySingleton(() => UpvoteNewsPost(serviceLocator<NewsPostRepo>()));
  serviceLocator.registerLazySingleton(() => FetchNewsFeedForHomeScreen(serviceLocator<NewsPostRepo>()));
  serviceLocator.registerLazySingleton(() => FetchAllNewsOfChannel(serviceLocator<NewsPostRepo>()));
  serviceLocator.registerLazySingleton(() => FetchNewsPost(serviceLocator<NewsPostRepo>()));
  
} 


