
import 'features/education/ui/providers/education_inquiry_provider.dart';
import 'features/image/ui/providers/image_write_provider.dart';

import 'features/education/ui/providers/education_read_provider.dart';
import 'features/education/ui/providers/education_write_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_names.dart';
import 'core/utils/themes/theme.dart';
import 'features/auth/ui/pages/signin.dart';
import 'features/auth/ui/providers/auth_provider.dart';
import 'dashboard.dart';
import 'features/image/ui/providers/image_read_provider.dart';
import 'features/page_entity/ui/providers/institute_page_read_provider.dart';
import 'features/page_entity/ui/providers/institute_page_create_provider.dart';
import 'features/user_profile/ui/providers/user_profile_read_provider.dart';
import 'home_page_provider.dart';
import 'init_dependency.dart';
import 'user_app_data_provider.dart';
import 'voting_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  List<ChangeNotifierProvider> providers = [
            ChangeNotifierProvider<UserAuthProvider>(create: (context)=> UserAuthProvider()),
            ChangeNotifierProvider<ImageReadProvider>(create: (context)=> ImageReadProvider()),
            ChangeNotifierProvider<ImageWriteProvider>(create: (context)=> ImageWriteProvider()),
            ChangeNotifierProvider<UserProfileReadProvider>(create: (context)=> UserProfileReadProvider()),
            ChangeNotifierProvider<EducationReadProvider>(create: (context) => EducationReadProvider()),
            ChangeNotifierProvider<EducationWriteProvider>(create: (context) => EducationWriteProvider()),
            ChangeNotifierProvider<EducationInquiryProvider>(create: (context) => EducationInquiryProvider()),
            ChangeNotifierProvider<InstitutePageWriteProvider>(create: (context) => InstitutePageWriteProvider()),
            ChangeNotifierProvider<InstitutePageReadProvider>(create: (context) => InstitutePageReadProvider()),
            ChangeNotifierProvider<UserAppDataProvider>(create: (context) => UserAppDataProvider()),
            ChangeNotifierProvider<HomePageProvider>(create: (context) => HomePageProvider()),
            ChangeNotifierProvider<VotingProvider>(create: (context) => VotingProvider()),
          ];
  if (!kIsWeb) {
    await getApplicationDocumentsDirectory().then((docDir){
      Hive.init(docDir.path);
    });
    await initDependencies().then((value) async{
      Animate.restartOnHotReload = true;
      runApp(
        MultiProvider(
          providers: providers,
          child: (const MyApp()),
        ));
    });
    
  } else {

    Hive.init(null); // doesn't need to provide directory path for browser

    await initDependencies().then((value) async{
      Animate.restartOnHotReload = true;
      runApp(
        MultiProvider(
          providers: providers,
          child: (const MyApp()),
        ));
    });
    
  }
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppNames.nameOfTheApp,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream: context.read<UserAuthProvider>().getCurrentUserAuth(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator());
          }
          if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            var userAuth = snapshot.data ;
            
            if(userAuth == null) {
              return const SignInView();
            } else {
              return FutureBuilder(
                future: context.read<UserProfileReadProvider>().fetchCurrentUser(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator());
                  }
                  if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                    var currentUser = snapshot.data ;
                    context.read<UserAppDataProvider>().init(userAuth: userAuth);
                    if(currentUser != null) {
                      return const Dashboard();
                    }
                  }
                  return const Dashboard(); 
                }
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator());
        },
        
      ),
    );
  }
}
