import 'dart:math';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../core/utils/image/image_loader_func.dart';
import '../providers/edit_user_profile_provider.dart';

class EditProfilePic extends StatefulWidget {
  const EditProfilePic({super.key});

  @override
  State<EditProfilePic> createState() => _EditProfilePicState();
}

class _EditProfilePicState extends State<EditProfilePic> {
  
  @override
  Widget build(BuildContext context) {
    final image = context.watch<EditUserProfileProvider>().profilePic;
    dekhao("image is null.");

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipOval(
                child: Container(
                  height: min(140, constraints.maxWidth ),
                  width: min(140, constraints.maxWidth),
                  decoration: BoxDecoration(
                    color: AppColors.context(context).textColor,
                    borderRadius: BorderRadius.circular(8000000)
                  ),
                  child: image == null 
                    ? Icon(
                        Icons.image, 
                        color: AppColors.context(context).textColor.withOpacity(.7), 
                        size: min(140, constraints.maxWidth / 2) - 6,
                      )
                    : Image.memory(image, fit: BoxFit.cover,),
                ),
              ),
              Positioned(
                bottom: 8,
                left: min(140, constraints.maxWidth) - 40,
                child: InkWell(
                  onTap: () async{
                    await pickImage().then((value) {
                      dekhao("value fetched");
                      dekhao("image len ${value?.length}");
                      if(value != null && context.mounted) {
                        dekhao("value fetched is not null");
                        context.read<EditUserProfileProvider>().setProfilePic(value);
                      }
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.context(context).backgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.context(context).textColor,
                        child:  Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.context(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
              // SizedBox(
              //   height: 60,
              //   width: constraints.maxWidth / 2,
              //   child: Padding(
              //     padding: const EdgeInsets.only(right: 4.0),
              //     child: FittedBox(
              //       fit: BoxFit.scaleDown,
              //       child: UploadImage(
              //         onPick: (pickedImage) {
              //           context.read<EditAdminProvider>().setProfilePic(pickedImage);
              //         },
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }

}