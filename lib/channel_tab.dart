import 'package:dormsity/core/utils/enums/page_enums.dart';
import 'package:dormsity/core/utils/routing/smooth_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_colors.dart';
import 'core/utils/constants/app_sizes.dart';
import 'features/channel/domain/entities/channel.dart';
import 'features/page_entity/domain/entities/page_public.dart';
import 'features/post/ui/pages/create_news_post_screen.dart';
import 'features/post/ui/widgets/news_post_tile.dart';
import 'page_view_provider.dart';
import 'user_app_data_provider.dart';

class ChannelTab extends StatefulWidget {
  final ChannelNameType channelNameType;
  const ChannelTab({super.key, required this.channelNameType});

  @override
  State<ChannelTab> createState() => _ChannelTabState();
}

class _ChannelTabState extends State<ChannelTab> {
  Channel? channel;

  @override
  Widget build(BuildContext context) {
    final watcher1 = context.watch<PageViewProvider>().fetchingChannelStatus;
    final watcher2 = context.watch<PageViewProvider>().fetchingPostsStatus;

    channel = context.read<PageViewProvider>().channels[widget.channelNameType.channelDocId];
    //dekhao("Showing channel is ${channel.toString()}");
    if(channel == null) return const Center(child: CircularProgressIndicator());
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                title: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      
                      if(widget.channelNameType.channelType == ChannelType.news  && 
                          context.read<UserAppDataProvider>().adminChannelIdList.contains(widget.channelNameType.channelDocId) 
                      ) Flexible(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: _barLeft(widget.channelNameType),
                      )),

                      if(widget.channelNameType.channelType == ChannelType.complaint  && 
                          context.read<UserAppDataProvider>().followingChannelIdList.contains(widget.channelNameType.channelDocId) 
                      ) Flexible(child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: _barLeft(widget.channelNameType),
                      )),

                      _barRight(widget.channelNameType),
                    ],
                  )
              ),
                      
              if(channel!.channelType == ChannelType.news && context.read<PageViewProvider>().newsPostOfChannel[channel!.docId] != null) SliverList(
                
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final newsPost = context.read<PageViewProvider>().newsPostOfChannel[channel!.docId]![index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8, right: 8),
                      child: Container(
                        //height: 200,
                        //width: constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: AppColors.context(context).backgroundColor,
                          border: Border(
                            top: BorderSide(color: AppColors.context(context).textColor),
                            bottom: index == context.read<PageViewProvider>().newsPostOfChannel[channel!.docId]!.length - 1 
                              ? BorderSide(color: AppColors.context(context).textColor)
                              : BorderSide.none
                          )
                        ),
                        child:  NewsPostTile(newsPost: newsPost,)
                      ),
                    );
                  },
                  childCount: context.read<PageViewProvider>().newsPostOfChannel[channel!.docId]?.length ?? 0, // Set the number of items in the list
                ),
              ),
            ],
          ); 
      },
    );
  }

  Widget _newsPostTile() {
    return Container(

    );
  }

  Widget _barLeft(ChannelNameType channelNameType){
    if(channel == null) return Container();
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          borderRadius: AppSizes.largeBorderRadius,
          onTap: () {
            if(channel!.channelType == ChannelType.news) {
              Navigator.push(
                context, 
                SmoothPageTransition().rightToLeft(
                  secondScreen: CreateNewsPostScreen(
                    channel: channel!, 
                    pagePublic: context.read<PageViewProvider>().pagePub, 
                    userAuth: context.read<PageViewProvider>().userAuth,
                  )
                )
              ).then((_) async{
                if(context.mounted) context.read<PageViewProvider>().getNewsChannelPosts(channelDocId: channel!.docId);
              });
            }
          },
          child: Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              color: Colors.transparent,//AppColors.context(context).contentBoxGreyColor.withOpacity(.6),
              border: Border.all(color: AppColors.context(context).contentBoxGreyColor),
              borderRadius: AppSizes.largeBorderRadius,
            ),
            child:
             widget.channelNameType.channelType == ChannelType.news
                && context.read<UserAppDataProvider>().adminChannelIdList.contains(widget.channelNameType.channelDocId)
              ?
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text("Write Something", style: Theme.of(context).textTheme.labelMedium,),
              )
              : widget.channelNameType.channelType == ChannelType.complaint  && 
                            context.read<UserAppDataProvider>().followingChannelIdList.contains(widget.channelNameType.channelDocId)
                ?
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Raise a complaint", style: Theme.of(context).textTheme.labelMedium,),
                )
                : null
          ),
        );
      }
    );
  }

  
  Widget _barRight(ChannelNameType channelNameType){
    if(channel == null) return Container();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            
            context.read<UserAppDataProvider>().adminChannelIdList.contains(channelNameType.channelDocId) 
                ? Icon(Icons.admin_panel_settings, color: AppColors.context(context).accentColor,)
                : context.read<UserAppDataProvider>().followingChannelIdList.contains(channelNameType.channelDocId) 
                  ? Container(
                    decoration: BoxDecoration(
                      color: AppColors.context(context).textColor,
                      borderRadius: AppSizes.smallBorderRadius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text("Unfollow", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.context(context).contentBoxColor, fontWeight: FontWeight.bold)),
                    )
                  )
                  : Container(
                    decoration: BoxDecoration(
                      color: AppColors.context(context).accentColor,
                      borderRadius: AppSizes.smallBorderRadius
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                      child: Text("Follow", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),),
                    )
                  ),
                  Text(
                    "${channel!.follwersCount + channel!.adminIds.length} follower${channel!.follwersCount + channel!.adminIds.length == 1 ? '' : 's'}",
                    style: Theme.of(context).textTheme.labelMedium
                  ),
          ],
        );
      },
    );
  }
}