import 'package:dormsity/core/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../auth/ui/pages/signin.dart';
import '../../../auth/ui/providers/auth_provider.dart';
import '../../../page_entity/domain/entities/page_public.dart';
import '../providers/channel_create_provider.dart';
import '../widgets/channel_name_preview.dart';
import '../widgets/channel_text_input_widget.dart';
import '../widgets/create_channel_button.dart';
import '../widgets/select_channel_type.dart';

class CreateChannelScreen extends StatefulWidget {
  final PagePublic pagePublic;
  const CreateChannelScreen({super.key, required this.pagePublic,});

  @override
  State<CreateChannelScreen> createState() => _CreateChannelScreenState();
}

class _CreateChannelScreenState extends State<CreateChannelScreen> {

  
  
  
  @override
  Widget build(BuildContext context) {

    final currentUser = context.read<UserAuthProvider>().userAuth;

    if(currentUser == null) {
      return const SignInView();
    }

    return ChangeNotifierProvider<ChannelCreateProvider>(
      create: (context)=> ChannelCreateProvider(
        pagePublic: widget.pagePublic,
        currentUserAuth: context.read<UserAuthProvider>().userAuth!,
      ),
      
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: AppColors.context(context).backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: .5,
                  //   decoration: BoxDecoration(
                  //     color: Colors.transparent,
                  //     border: Border(bottom: BorderSide(color: AppColors.context(context).textColor))
                  //   ),
                  // ),

                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 10,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColors.context(context).textColor,
                          borderRadius: AppSizes.largeBorderRadius
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 8,),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ChannelNamePreview(),
                        CloseButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 18.0, right: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  
                                  Text("Create Channel", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text("* Indicates required", style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic),),
                            
                                  const SizedBox(
                                    height: 40,
                                  ),
                                    
                                    
                                  const SelectChannelType(),
                                    
                                  const SizedBox(
                                    height: 20,
                                  ),
                                    
                                  ChannelTextInputWidget(
                                    hintText: "", 
                                    labelText: "Channel name*", 
                                    suffixIcon: null, 
                                    initialTextData: '',
                                    onChanged: (text) {
                                      context.read<ChannelCreateProvider>().setChannelName(text);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                            
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CreateChannelButton(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          
          );
        },
      ),
    );
  }

}