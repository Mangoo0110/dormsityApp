import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../providers/news_post_create_provider.dart';
import '../widgets/channel_text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../channel/domain/entities/channel.dart';
import '../../../page_entity/domain/entities/page_public.dart';
import '../widgets/post_news_button.dart';

class CreateNewsPostScreen extends StatefulWidget {
  final Channel channel;
  final PagePublic pagePublic;
  final UserAuth userAuth;
  const CreateNewsPostScreen({super.key, required this.channel, required this.pagePublic, required this.userAuth});

  @override
  State<CreateNewsPostScreen> createState() => _CreateNewsPostScreenState();
}

class _CreateNewsPostScreenState extends State<CreateNewsPostScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ChangeNotifierProvider(
          create: (context) => NewsPostCreateProvider(channel: widget.channel, pagePublic: widget.pagePublic, userAuth: widget.userAuth),
          child: Scaffold(
            appBar: AppBar(
              leading: CloseButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: const [
                PostNewsButton()
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: NewsPostTextInputWidget(
                      initialTextData: '', 
                      onChanged: (text){
                        
                      }),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: AppSizes.largeBorderRadius,
                        onTap: () {
                          
                        },
                        child: Container(
                          width: 130,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: AppSizes.largeBorderRadius
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,       
                              children: [
                                Text("Picture"),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.add, size: 30,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ),
        );
      },
    );
  }
}