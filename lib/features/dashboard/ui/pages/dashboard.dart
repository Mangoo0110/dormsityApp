
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../dorm/ui/pages/dorm_page.dart';
import '../../../user_profile/ui/pages/edit_profile.dart';
import '../../../user_profile/ui/pages/profile_page.dart';
import '../../../user_profile/ui/providers/user_provider.dart';
import '../../../image/ui/widgets/show_round_image.dart';
import '../providers/dashboard_controller_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  

  
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);

    _tabController.addListener(() {
      if(_tabController.index != context.read<DashboardControllerProvider>().currentPage) {
        context.read<DashboardControllerProvider>().changeCurrentPage(_tabController.index);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _tabController.animateTo(context.read<DashboardControllerProvider>().currentPage);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: FutureBuilder(
            future: context.read<UserProvider>().fetchCurrentUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done || ConnectionState.active:
                  if(!snapshot.hasData){
                    return  EditProfilePage(
                      onCancel: () {
                       // Navigator.pop(context);
                        //SystemNavigator.pop();
                      },
                    );
                  } 
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Scaffold(
                        primary: true,
                        bottomNavigationBar: Padding(
                          padding: const EdgeInsets.only(top: .8),
                          child: _tabBar(height: 54),
                        ),
                        body: TabBarView(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: const [
                            MyDormPage(),
                            ProfilePage(),
                          ],
                        ),
                      );
                    }
                  );
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
        return SizedBox(
          height: height,
          width: constraints.maxWidth,
          
          
          child: Card(
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
                  
                  Tab(icon: const Icon(Icons.other_houses), iconMargin: const EdgeInsets.only(bottom: 4), text: 'My dorm', height: constraints.maxHeight,),
                  Tab(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: AppColors.context(context).textColor,
                        borderRadius: BorderRadius.circular(500000000)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ShowRoundImage(imageId: context.read<UserProvider>().currentAdmin!.id, height: 30, width: 30,)),
                    ), 
                    iconMargin: const EdgeInsets.only(bottom: 4), text: 'Profile', height: constraints.maxHeight,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}