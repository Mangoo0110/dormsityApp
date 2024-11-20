import 'package:dormsity/core/utils/constants/app_colors.dart';

import 'channel_tab.dart';
import 'page_view_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';


class PageChannelTabs extends StatefulWidget {
  const PageChannelTabs({super.key});

  @override
  State<PageChannelTabs> createState() => _PageChannelTabsState();
}

class _PageChannelTabsState extends State<PageChannelTabs> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.context(context).contentBoxColor,
          body: TabBarView(
            controller: context.read<PageViewProvider>().tabController,
            //physics: const NeverScrollableScrollPhysics(),
            children: context.read<PageViewProvider>().pagePub.channelList.map((e) {
              return ChannelTab(channelNameType: e, key: UniqueKey(),);
            }).toList()
          )
        );
      },
    );
  }

  

}


