
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/textfields/name_textfield.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../auth/ui/providers/auth_provider.dart';
import '../../../image/ui/providers/app_image_provider.dart';
import '../providers/user_provider.dart';
import '../providers/edit_user_profile_provider.dart';
import '../widgets/user_info_save_button.dart';
import '../widgets/edit_profile_pic.dart';

class EditProfilePage extends StatefulWidget {
  final VoidCallback onCancel;
  const EditProfilePage({super.key, required this.onCancel});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final TextEditingController _nameInptCntrl = TextEditingController();
  final TextEditingController _professionInptCntrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _nameInptCntrl.text = context.read<UserProvider>().currentAdmin == null ? '' : context.read<UserProvider>().currentAdmin!.fullName;
    _professionInptCntrl.text = context.read<UserProvider>().currentAdmin == null ? '' : context.read<UserProvider>().currentAdmin!.profession;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditUserProfileProvider>(
      create: (context)=> EditUserProfileProvider(
        context.read<UserProvider>().currentAdmin, 
        context.read<UserAuthProvider>().userAuth!, 
        context.read<UserProvider>().currentAdmin == null ? null : context.read<AppImageProvider>().findImage(imageId: context.read<UserProvider>().currentAdmin!.imageId) ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Admin Info', style: Theme.of(context).textTheme.titleMedium,),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: UserInfoSaveButton(),
                )
              ],
              leading: CloseButton(
                color: AppColors.context(context).textColor, 
                onPressed: () {   
                  widget.onCancel();
                },
              ),
            ),
            body: SizedBox(
              width: min(550, constraints.maxWidth),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // image section
                        
                      const SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: EditProfilePic(),
                        ),
                      ),
                        
                      const SizedBox(height: 10,),
              
                      _inputFullName(),
                        
                      const SizedBox(height: 10,),
                  
                      _inputProfession(),
                      
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _inputFullName() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 80,
          width: constraints.maxWidth,
          child: NameTextfield(
            maxLines: 1, 
            onChanged: (text){
              context.read<EditUserProfileProvider>().setFullName(text.trim());
            },
            controller: _nameInptCntrl, 
            hintText: 'Type your full name', 
            labelText: 'Full Name', validationCheck: (text){},
          ),
        );
      },
    );
  }

  Widget _inputProfession() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 80,
          width: constraints.maxWidth,
          child: NameTextfield(
            maxLines: 1, 
            onChanged: (text){
              context.read<EditUserProfileProvider>().setProfession(text.trim());
            },
            controller: _professionInptCntrl, 
            hintText: 'e.g Student, Teacher', 
            labelText: 'Profession', validationCheck: (text){},
          ),
        );
      },
    );
  }

}