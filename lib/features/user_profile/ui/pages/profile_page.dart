


import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../core/utils/routing/smooth_page_transition.dart';
import '../../../image/ui/widgets/show_round_image.dart';
import '../providers/user_provider.dart';
import 'edit_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

  //final String _appBarName = "PROFILE";
  @override
  Widget build(BuildContext context) {
    int baseDelay = 50;
    int baseDuration = 300;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            shadowColor: AppColors.context(context).textColor,
            elevation: 1,
            centerTitle: true,
            title: Text('P R O F I L E', style: Theme.of(context).textTheme.titleMedium,)
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // image section
                    
                  SizedBox(
                    height: 130,
                    width: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShowRoundImage(imageId: context.read<UserProvider>().currentAdmin!.id),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(context.read<UserProvider>().currentAdmin!.fullName, style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: 4,),
                            Text(context.read<UserProvider>().currentAdmin!.profession, style: Theme.of(context).textTheme.titleSmall),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            //color: AppColors.context(context).buttonColor,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(SmoothPageTransition().bottomToUp(secondScreen: EditProfilePage(
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                )));
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.mode_edit_outlined, color: AppColors.context(context).buttonColor, size: AppSizes.mediumTextSize + 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Text("Edit Profile", style: TextStyle(color: AppColors.context(context).buttonColor, fontSize: AppSizes.mediumTextSize, fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppColors.context(context).contentBoxColor))
                    ),
                  ),
                  _actionOptionWidget(
                    iconData: Icons.school, 
                    actionName: "University",
                    onTap: () {
                      
                    },
                  ).animate().fadeIn(delay:  Duration(milliseconds: baseDelay * 1), duration: Duration(milliseconds: baseDuration)),

                  // _actionOptionWidget(
                  //   iconData: Icons., 
                  //   actionName: "",
                  //   onTap: () {
                      
                  //   },
                  // ).animate().fadeIn(delay:  Duration(milliseconds: baseDelay * 2), duration: Duration(milliseconds: baseDuration)),
                  
                  _actionOptionWidget(
                    iconData: Icons.key, 
                    actionName: "Change password",
                    onTap: () {
                      
                    },
                  ).animate().fadeIn(delay:  Duration(milliseconds: baseDelay * 3), duration: Duration(milliseconds: baseDuration)),

                  _actionOptionWidget(
                    iconData: Icons.logout, 
                    actionName: "Sign out",
                    onTap: () {
                      
                    },
                  ).animate().fadeIn(delay:  Duration(milliseconds: baseDelay * 4), duration: Duration(milliseconds: baseDuration)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _universityAction(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.context(context).contentBoxColor)),
          ),
          child: InkWell(
            onTap: () {
              
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Text("Universities", style: Theme.of(context).textTheme.bodyLarge,),
                
                    InkWell(
                      onTap: () {
                        
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.add, color: AppColors.context(context).textColor,),
                          ),
                          Text("Add", style: Theme.of(context).textTheme.bodyLarge,),
                        ],
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        ); 
      },
    );
  }



  Widget _actionOptionWidget({
    required IconData iconData, 
    required String actionName,
    required VoidCallback onTap,
  }){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.context(context).contentBoxColor)),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 14.0),
                  child: Icon(iconData, color: AppColors.context(context).textColor,),
                ),
                Text(actionName, style: Theme.of(context).textTheme.bodyLarge,),
              ],
            ),
          ),
        );
      },
    );
  }
 

}