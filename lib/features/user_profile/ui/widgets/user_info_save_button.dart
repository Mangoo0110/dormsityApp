

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../dashboard/ui/pages/dashboard.dart';
import '../providers/edit_user_profile_provider.dart';

class UserInfoSaveButton extends StatefulWidget {
  const UserInfoSaveButton({super.key});

  @override
  State<UserInfoSaveButton> createState() => _UserInfoSaveButtonState();
}

class _UserInfoSaveButtonState extends State<UserInfoSaveButton> {
  bool canSave = false;

  @override
  Widget build(BuildContext context) {
    canSave =  context.watch<EditUserProfileProvider>().canSave;
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: () async{
            if(canSave) {
              await context.read<EditUserProfileProvider>()
              .saveAdminInfo(
                onDone: () {
                  Navigator.of(context)
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const Dashboard()), (route) => false);
                },
              );
            }
            
          },
          child: Center(
            child: Icon(
              Icons.done,
              size: AppSizes.largeIconSize,
              color: (canSave) ? AppColors.context(context).primaryColor: AppColors.context(context).textColor.withOpacity(.4),
            )
          )
        
        );
      },
    );
  }


}