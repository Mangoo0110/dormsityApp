

import 'package:dormsity/features/user_profile/ui/providers/user_profile_read_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import '../../../../dashboard.dart';
import '../../../image/ui/providers/image_write_provider.dart';
import '../providers/user_profile_write_provider.dart';

class UserInfoSaveButton extends StatefulWidget {
  const UserInfoSaveButton({super.key});

  @override
  State<UserInfoSaveButton> createState() => _UserInfoSaveButtonState();
}

class _UserInfoSaveButtonState extends State<UserInfoSaveButton> {

  Future<void> save() async{
    if(context.read<ImageWriteProvider>().canSave && context.read<UserProfileWriteProvider>().writeType == WriteType.updating) {
              await context.read<ImageWriteProvider>().saveImage().then((url) async{
                if(mounted) {
                  if(url != null && url != context.read<UserProfileReadProvider>().currentUser?.imageUrl) context.read<UserProfileWriteProvider>().setImageUrl(url);
                  await context.read<UserProfileWriteProvider>()
                  .saveUserInfo(
                    onDone: () {
                      Navigator.pop(context);
                    },
                  );
                }
              });
            }else if(context.read<UserProfileWriteProvider>().canSave) {
              await context.read<ImageWriteProvider>().saveImage().then((url) async{
                if(mounted) {
                  if(url != null) context.read<UserProfileWriteProvider>().setImageUrl(url);
                  await context.read<UserProfileWriteProvider>()
                  .saveUserInfo(
                    onDone: () async{
                      await context.read<UserProfileReadProvider>().fetchCurrentUser(forceFetch: true).then((_){
                        if(mounted) Navigator.pop(context);
                      });
                    },
                  );
                }
              });
            }
  }
  bool canSave = false;

  @override
  Widget build(BuildContext context) {
    canSave =  context.watch<UserProfileWriteProvider>().canSave || context.watch<ImageWriteProvider>().canSave;
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () async{
            save();
            
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