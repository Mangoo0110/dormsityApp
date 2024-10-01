import 'package:cloud_firestore/cloud_firestore.dart';
import '../features/auth/domain/usecases/get_current_user.dart';
import '../features/auth/domain/usecases/user_is_logged_in.dart';
import '../features/auth/domain/usecases/user_signin.dart';
import '../features/image/domain/usecases/save_image.dart';
import '../firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'features/user_profile/data/datasources/local/user_local_datasource.dart';
import 'features/user_profile/data/datasources/remote/user_remote_datasource.dart';
import 'features/user_profile/data/repositories/user_repo_impl.dart';
import 'features/user_profile/domain/usecases/fetch_user_info.dart';
import 'features/user_profile/domain/usecases/save_user_info.dart';
import 'features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repo_impl.dart';
import 'features/auth/domain/usecases/user_signup.dart';
import 'features/image/data/datasources/firebase/image_firebase_datasource.dart';
import 'features/image/data/repositories/image_repo_impl.dart';
import 'features/image/domain/usecases/delete_image.dart';
import 'features/image/domain/usecases/fetch_image.dart';

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
  serviceLocator.registerLazySingleton(() => SaveImage(serviceLocator<ImageRepoImpl>()));
  
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
  serviceLocator.registerLazySingleton(() => FetchUserInfo(serviceLocator<UserRepoImpl>()));
}