
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
import 'features/dashboard/ui/pages/dashboard.dart';
import 'features/dashboard/ui/providers/dashboard_controller_provider.dart';
import 'features/image/ui/providers/app_image_provider.dart';
import 'features/user_profile/ui/providers/user_provider.dart';
import 'init_dependency.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  List<ChangeNotifierProvider> providers = [
            ChangeNotifierProvider<UserAuthProvider>(create: (context)=> UserAuthProvider()),
            ChangeNotifierProvider<AppImageProvider>(create: (context)=> AppImageProvider()),
            ChangeNotifierProvider<UserProvider>(create: (context)=> UserProvider()),
            ChangeNotifierProvider<DashboardControllerProvider>(create: (context) => DashboardControllerProvider()),
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
          providers: [
            ChangeNotifierProvider<UserAuthProvider>(create: (context)=> UserAuthProvider()),
            ChangeNotifierProvider<AppImageProvider>(create: (context)=> AppImageProvider()),
            ChangeNotifierProvider<UserProvider>(create: (context)=> UserProvider()),
            ChangeNotifierProvider<DashboardControllerProvider>(create: (context) => DashboardControllerProvider()),
            
          ],
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
            var user = snapshot.data ;
            
            if(user == null) {
              return const SignInView();
            } else {
              return FutureBuilder(
                future: context.read<UserProvider>().fetchCurrentUser(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator());
                  }
                  if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
                    var store = snapshot.data ;
                    if(store != null) {
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
