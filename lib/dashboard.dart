


import 'features/user_profile/ui/pages/current_user_profile.dart';

import 'core/utils/func/dekhao.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_colors.dart';
import 'features/image/ui/widgets/show_round_image.dart';
import 'home_page.dart';
import 'features/user_profile/ui/pages/edit_profile.dart';
import 'features/user_profile/ui/providers/user_profile_read_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  int _currentPage = 0;
  
  
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    //context.read<AdminMangeReadProvider>().getUserInstituteAndHubs(userAuth: context.read<UserAuthProvider>().userAuth!);
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //context.read<AdminMangeReadProvider>().getUserInstituteAndChannels(userAuth: context.read<UserAuthProvider>().userAuth!);
    _tabController.addListener(() {
      if(_tabController.index != _currentPage) {
        _currentPage = _tabController.index;
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(_currentPage);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: FutureBuilder(
            future: context.read<UserProfileReadProvider>().fetchCurrentUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done || ConnectionState.active:
                  if(!snapshot.hasData){
                    dekhao("current ${'\n\n\n'} user ${'\n\n\n'} is ${'\n\n\n'} null");
                    return  EditProfilePage(
                      onCancel: () {
                       // Navigator.pop(context);
                        //SystemNavigator.pop();
                      },
                    );
                  } 
                  return const HomePage();
                  // return LayoutBuilder(
                  //   builder: (context, constraints) {
                  //     return Scaffold(
                  //       primary: true,
                  //       // bottomNavigationBar: Padding(
                  //       //   padding: const EdgeInsets.only(top: .8),
                  //       //   child: _tabBar(height: 50),
                  //       // ),
                  //       body: TabBarView(
                  //         controller: _tabController,
                  //         physics: const NeverScrollableScrollPhysics(),
                  //         children: const [
                  //           HomePage(),
                  //           //ComplainsPage(),
                  //           CurrentUserProfile()
                  //         ],
                  //       ),
                  //     );
                  //   }
                  // );
                default:
                  return const Center(child: CircularProgressIndicator());
              }
              
            }
          ),
        );
      }
    );
  }

  Widget _tabBar({required double height}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: height,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            color: AppColors.context(context).tabBarColor,
            border: Border(top: BorderSide(color: AppColors.context(context).textColor.withOpacity(.6), width: .5))
          ),
          
          child: Center(
            child: TabBar(
              dividerHeight: 0,
              controller: _tabController,
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.label,
              // onTap: (value) {
              //   // setState(() {
              //   //   currentTabIndex = value;
              //   // });
              // },
              tabs:  [
                
                Tab(icon: const Icon(Icons.home_rounded, size: 26,), iconMargin: const EdgeInsets.only(bottom: 0), text: 'Home', height: height,),
                //Tab(icon: const Icon(Icons.mark_as_unread_sharp, size: 28,), iconMargin: const EdgeInsets.only(bottom: 0), text: 'Complains', height: height,),
                //Tab(icon: const Icon(Icons.admin_panel_settings, size: 28,), iconMargin: const EdgeInsets.only(bottom: 0), text: 'Manage', height: height,),
                Tab(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: AppColors.context(context).textColor,
                      borderRadius: BorderRadius.circular(500000000)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ShowRoundImage(imageUrl: context.read<UserProfileReadProvider>().currentUser!.imageUrl, radius: 26,)),
                  ), 
                  iconMargin: const EdgeInsets.only(top: 1, bottom: 0), text: 'Profile', height: height,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
