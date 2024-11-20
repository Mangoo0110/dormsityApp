

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_colors.dart';
import 'core/utils/constants/app_sizes.dart';
import 'core/utils/enums/common_enums.dart';
import 'core/utils/routing/smooth_page_transition.dart';
import 'features/auth/ui/providers/auth_provider.dart';
import 'features/image/ui/widgets/show_round_image.dart';
import 'features/page_entity/ui/pages/create_institute_page.dart';
import 'features/page_entity/ui/providers/institute_page_read_provider.dart';
import 'features/post/ui/widgets/news_post_tile.dart';
import 'features/user_profile/ui/pages/user_profile_popup.dart';
import 'features/user_profile/ui/providers/user_profile_read_provider.dart';
import 'home_page_provider.dart';
import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<HomePageProvider>().fetchNewsFeedForHomeScreen(userAuth: context.read<UserAuthProvider>().userAuth!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final watcher = context.watch<HomePageProvider>().fetchingPostsStatus;

    final newsPosts = context.watch<HomePageProvider>().newsPostFeed;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.context(context).contentBoxColor,
          appBar: AppBar(
            centerTitle: false,
            leading: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 6, right: 4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500000000),
                  onTap: () {
                    context.read<UserProfileReadProvider>().fetchUserInfo(userId: context.read<UserAuthProvider>().userAuth!.id).then((userPub){
                      if(userPub == null) {
                        Fluttertoast.showToast(msg: "Facing some error. Check your internet connection.");
                        return;
                      }
                      if(context.mounted) {
                        Navigator.of(context).push(PageRouteBuilder(
                          opaque: false,
                          barrierDismissible: true,
                          transitionDuration: const Duration(milliseconds: 400),
                          reverseTransitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (BuildContext context, b, e) {
                            return  UserProfilePopup(
                              userPub: userPub,
                            );
                          })
                        );
                      }
                    });
                    
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(500000000)
                    ),
                    child: Hero(
                      tag: context.read<UserProfileReadProvider>().currentUser?.imageUrl ?? 'null',
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: ShowRoundImage(imageUrl: context.read<UserProfileReadProvider>().currentUser!.imageUrl, radius: 25,)),
                    ),
                  ),
                ),
              ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.context(context).contentBoxGreyColor,
                      borderRadius: AppSizes.largeBorderRadius,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: AppSizes.largeBorderRadius,
                        onTap: () {
                          Navigator.push(context, SmoothPageTransition().rightToLeft(secondScreen: const SearchPage())).then((_){
                            if(context.mounted) context.read<InstitutePageReadProvider>().searchClear();
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              Padding(
                                padding: EdgeInsets.only(left: 6.0),
                                child: Text(
                                  "Search page"
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context, 
                            SmoothPageTransition().bottomToUp(
                              secondScreen: CreateInstitutePage(
                                oldInstitutePub: null, 
                                userAuth: context.read<UserAuthProvider>().userAuth!,
                              )
                            ));
                        },
                        child: Stack(
                          children: [
                            Icon(Icons.space_dashboard_outlined, size: 35, color: AppColors.context(context).textColor),
                            Positioned(
                              bottom: 0,
                              right: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  backgroundBlendMode: BlendMode.src,
                                  color: AppColors.context(context).textColor,
                                  borderRadius: BorderRadius.circular(800000000),
                                  border: Border.all(color: Colors.transparent, width: 2)
                                ),
                                child: Icon(
                                  Icons.add, 
                                  size: 15,
                                  color: AppColors.context(context).contentBoxColor,
                                )
                              )
                            )
                          ],
                        ),
                      ),
                      // InkWell(
                      //   borderRadius: AppSizes.largeBorderRadius,
                      //   onTap: () {
                          
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
                      //     child: Icon(Icons.admin_panel_settings, size: AppSizes.largeIconSize, color: AppColors.context(context).accentColor,),
                      //   ),
                      // ),
                                    
                      
                    ],
                  ),
                )
              ],
            ),
          ),
          body:(watcher == FetchingStatus.fetching) 
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: newsPosts.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                      child: Container(
                        //height: 200,
                        //width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: AppColors.context(context).backgroundColor,
                          border: Border(
                            top: BorderSide(color: AppColors.context(context).textColor),
                            bottom: index == newsPosts.length - 1 
                              ? BorderSide(color: AppColors.context(context).textColor)
                              : BorderSide.none
                          )
                        ),
                        child:  NewsPostTile(
                          newsPost: newsPosts[index], 
                        )
                      ),
                    );
                },
              )
        );
      },
    );
  }
}





