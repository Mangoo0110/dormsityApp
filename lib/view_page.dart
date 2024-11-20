import 'package:dormsity/features/channel/ui/pages/create_channel_screen.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_colors.dart';
import 'core/utils/constants/app_sizes.dart';
import 'features/auth/ui/providers/auth_provider.dart';
import 'features/image/ui/widgets/show_rect_image.dart';
import 'package:flutter/material.dart';

import 'features/page_entity/domain/entities/page_public.dart';
import 'page_channel_tabs.dart';
import 'page_view_provider.dart';



class ViewPage extends StatefulWidget {
  final PagePublic page;
  const ViewPage({super.key, required this.page});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> with SingleTickerProviderStateMixin{
  
  late TabController _tabController;
  int _currentPage = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: widget.page.channelList.length, vsync: this, initialIndex: 0);
    //context.read<AdminMangeReadProvider>().getUserInstituteAndHubs(userAuth: context.read<UserAuthProvider>().userAuth!);
    
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final pagePub = widget.page;
    if(context.read<UserAuthProvider>().userAuth == null) {
      return const Scaffold(
        body: Center(
          child: Text("Error: User need to be logged in. Please login."),
        ),
      );
    }
    return ChangeNotifierProvider(
      create: (context) => PageViewProvider(pagePub: pagePub, userAuth: context.read<UserAuthProvider>().userAuth!, tabController: _tabController),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: AppColors.context(context).contentBoxColor,
            appBar: AppBar(
              title: Text(
                pagePub.pageName,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 2,
              ),
              actions: [
                if (pagePub.adminIds.contains(context.read<UserAuthProvider>().userAuth!.id))
                  InkWell(
                    borderRadius: AppSizes.largeBorderRadius,
                    onTap: () {
                      // Your admin action
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4),
                      child: Icon(Icons.admin_panel_settings,
                          size: AppSizes.largeIconSize, color: AppColors.context(context).accentColor),
                    ),
                  ),
              ],
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(child: _banner()), // Banner widget
                SliverToBoxAdapter(child: _largeVerticalGap()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Text(pagePub.pageName,
                        style: Theme.of(context).textTheme.titleLarge, maxLines: 2),
                  ),
                ),
                SliverToBoxAdapter(child: _smallVerticalGap()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: pagePub.description.isEmpty
                        ? Text(
                            "No description.",
                            maxLines: 4,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                  color: AppColors.context(context).textColor.withOpacity(.5),
                                  fontStyle: FontStyle.italic,
                                ),
                          )
                        : Text(
                            pagePub.description,
                            maxLines: 4,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                  ),
                ),
                SliverToBoxAdapter(child: _mediumVerticalGap()),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Channels', maxLines: 4, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor.withOpacity(.5)),),
                        
                        if(pagePub.adminIds.contains(context.read<UserAuthProvider>().userAuth!.id)) InkWell(
                          borderRadius: AppSizes.smallBorderRadius,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return CreateChannelScreen(pagePublic: widget.page);
                              },
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                            child: Icon(Icons.add)
                          )
                        ),
                      ],
                    ),
                  )
                ),

                //SliverToBoxAdapter(child: _mediumVerticalGap()),

                SliverAppBar(
                  
                  pinned: true,
                  floating: true,
                  backgroundColor: AppColors.context(context).contentBoxColor,
                  toolbarHeight: 0, // Remove extra padding in SliverAppBar
                  bottom: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    controller: _tabController,
                    tabs: widget.page.channelList
                        .map((channel) => Tab(
                          icon: Text(channel.channelName, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),),
                          text: "#${channel.channelType.name.toUpperCase()}"))
                        .toList(),
                  ),
                ),
              ],
              body: const PageChannelTabs(),
              // body: TabBarView(
              //   controller: _tabController,
              //   children: widget.page.channelList.map((channel) {
              //     return ListView.builder(
              //       padding: EdgeInsets.all(16.0),
              //       itemCount: 20, // Replace with actual item count
              //       itemBuilder: (context, index) {
              //         return ListTile(
              //           title: Text("${channel.channelName} - Item $index"),
              //         );
              //       },
              //     );
              //   }).toList(),
              // ),
            ),
          );
          
        },
      ),
    );
  }

  Widget _banner(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return ShowRectImage(imageUrl: widget.page.logoUrl, borderRadiusVal: 0, height: 150, width: constraints.maxWidth,);
      },
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
          
          child: Align(
            alignment: Alignment.topLeft,
            child: TabBar(
              dividerHeight: 0,
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.label,
              // onTap: (value) {
              //   // setState(() {
              //   //   currentTabIndex = value;
              //   // });
              // },
              tabs:  widget.page.channelList.map((e){
                return Tab(
                  icon: Text(e.channelName, style: Theme.of(context).textTheme.labelLarge,),
                  iconMargin: const EdgeInsets.only(bottom: 0), 
                  text: '#${e.channelType.name}', height: height,);
              }).toList()
            ),
          ),
        );
      },
    );
  }


  Widget _smallHorizontalGap() => const SizedBox(width: 6,);
  Widget _mediumHorizontalGap() => const SizedBox(width: 12,);
  Widget _smallVerticalGap() => const SizedBox(height: 6,);
  Widget _mediumVerticalGap() => const SizedBox(height: 12,);
  Widget _largeVerticalGap() => const SizedBox(height: 20,);
}