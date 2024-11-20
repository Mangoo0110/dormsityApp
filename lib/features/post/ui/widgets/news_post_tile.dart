import 'package:dormsity/core/utils/constants/app_colors.dart';
import 'package:dormsity/core/utils/constants/app_sizes.dart';
import 'package:dormsity/features/auth/ui/providers/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../voting_provider.dart';
import '../../domain/entities/news.dart';

class NewsPostTile extends StatefulWidget {
  final News newsPost;

  const NewsPostTile({
    super.key, 
    required this.newsPost,});

  @override
  State<NewsPostTile> createState() => _NewsPostTileState();
}

class _NewsPostTileState extends State<NewsPostTile> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _metaDetails(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(widget.newsPost.textContent, maxLines: 100, style: Theme.of(context).textTheme.labelLarge,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _tileBottomBar(),
            ),
          ],
        );
      },
    );
  }

  Widget _metaDetails(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(widget.newsPost.postMetaData.pageName.toString(), style: Theme.of(context).textTheme.labelLarge,),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text("#${widget.newsPost.postMetaData.channelType.name}/${widget.newsPost.postMetaData.channelName.toString()}", style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.context(context).textColor.withOpacity(.5)),),
            ),
          ],
        );
      }
    );
  }


  Widget _tileBottomBar(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedContainer(
          height: 40,
          decoration: BoxDecoration(
            color: widget.newsPost.upVoted == true
              ? AppColors.context(context).accentColor
              : widget.newsPost.downVoted == true
              ? AppColors.context(context).secondaryAccentColor
              : AppColors.context(context).textColor.withOpacity(.15),
            borderRadius: AppSizes.largeBorderRadius
          ),
          duration: const Duration(milliseconds: 300),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80000000),
                    onTap: () async{
                      await context.read<VotingProvider>()
                        .tappedUpVote(userAuth: context.read<UserAuthProvider>().userAuth!, newsPost: widget.newsPost).then((_){
                          setState(() {
                            
                          });
                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        widget.newsPost.upVoted == true 
                        ? Icons.thumb_up
                        : Icons.thumb_up_alt_outlined, 
                        size: AppSizes.mediumIconSize,),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Text(widget.newsPost.upVote.toString(), style: Theme.of(context).textTheme.labelLarge,),
                ),

                /// Down-vote
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(80000000),
                    onTap: () async{
                      context.read<VotingProvider>()
                      .tappedDownVote(userAuth: context.read<UserAuthProvider>().userAuth!, newsPost: widget.newsPost).then((_){
                          setState(() {
                            
                          });
                        });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        widget.newsPost.downVoted == true 
                        ? Icons.thumb_down
                        : Icons.thumb_down_alt_outlined, 
                        size: AppSizes.mediumIconSize,),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(duration: const Duration(milliseconds: 500));
      },
    );
  }
}