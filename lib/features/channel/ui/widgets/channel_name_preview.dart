import 'package:dormsity/core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../providers/channel_create_provider.dart';

class ChannelNamePreview extends StatefulWidget {
  const ChannelNamePreview({super.key});

  @override
  State<ChannelNamePreview> createState() => _ChannelNamePreviewState();
}

class _ChannelNamePreviewState extends State<ChannelNamePreview> {
  
  @override
  Widget build(BuildContext context) {
    final channelData = context.watch<ChannelCreateProvider>().createChannelParams;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(channelData.channelName.isEmpty ? 'Need name' : channelData.channelName, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor.withOpacity(.5),),),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text("#${channelData.channelType.name.toUpperCase()}", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor.withOpacity(.5), fontStyle: FontStyle.italic),),
        ),
      ],
    ).animate().fadeIn(duration: const Duration(milliseconds: 300));
  }
}