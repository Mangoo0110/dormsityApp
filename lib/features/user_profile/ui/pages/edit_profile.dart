
import 'dart:math';


import 'package:dormsity/core/utils/constants/data_field_key_names.dart';
import 'package:dormsity/core/utils/func/dekhao.dart';
import 'package:dormsity/features/auth/ui/pages/signin.dart';
import 'package:dormsity/features/education/ui/widgets/user_education_edit_list.dart';
import 'package:dormsity/features/user_profile/ui/widgets/input_birthdate.dart';
import 'package:dormsity/features/user_profile/ui/widgets/input_gender.dart';

import '../../../image/ui/widgets/image_show_upload.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../auth/ui/providers/auth_provider.dart';
import '../providers/user_profile_read_provider.dart';
import '../providers/user_profile_write_provider.dart';
import '../widgets/profile_text_input_widget.dart';
import '../widgets/user_info_save_button.dart';

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
    _nameInptCntrl.text = context.read<UserProfileReadProvider>().currentUser == null ? '' : context.read<UserProfileReadProvider>().currentUser!.fullName;
    _professionInptCntrl.text = context.read<UserProfileReadProvider>().currentUser == null ? '' : context.read<UserProfileReadProvider>().currentUser!.about;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    final currentUser = context.read<UserProfileReadProvider>().currentUser;

    if(currentUser == null) {
      return const SignInView();
    }

    dekhao("Edit profile of ${currentUser.toString()}");
    return ChangeNotifierProvider<UserProfileWriteProvider>(
      create: (context)=> UserProfileWriteProvider(
        currentUser, 
        context.read<UserAuthProvider>().userAuth!,),
      
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Scaffold(
            backgroundColor: AppColors.context(context).contentBoxColor,
            appBar: AppBar(
              title: Text('Edit profile bio', style: Theme.of(context).textTheme.titleMedium,),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // image section
                        
                      SizedBox(
                        height: 160,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ImageShowUpload(
                            radius: 140,
                            imageUrl: currentUser.imageUrl,
                            collectionName: FirebaseStorageCollections.kUserProfile,
                            docId: currentUser.docId,
                          ),
                        ),
                      ),
                        
                      const SizedBox(height: 10,),
              
                      SizedBox(
                        height: 70,
                        width: constraints.maxWidth,
                        child: ProfileTextInputWidget(
                          onChanged: (text){
                            context.read<UserProfileWriteProvider>().setFullName(text.trim());
                          },
                          hintText: 'Type your full name', 
                          labelText: 'Full Name', 
                          suffixIcon: null, 
                          initialTextData: currentUser.fullName, 
                        ),
                      ),
                        
                      const SizedBox(height: 25,),
                  
                      SizedBox(
                        height: 70,
                        width: constraints.maxWidth,
                        child: ProfileTextInputWidget(
                          onChanged: (text){
                            context.read<UserProfileWriteProvider>().setFullName(text.trim());
                          },
                          hintText: 'Type your interest, skill, or simply about you', 
                          labelText: 'Description', 
                          suffixIcon: null, 
                          initialTextData: currentUser.about, 
                        ),
                      ),

                      const SizedBox(height: 25,),
                  
                      InputGender(
                        initialGender: currentUser.gender, 
                        onSelect: (selectedGender){
                          if(selectedGender != null) context.read<UserProfileWriteProvider>().setGender(selectedGender);
                        }
                      ),
                      
                      const SizedBox(height: 25,),

                      InputBirthdate(
                        initialBirthdate: currentUser.birthdate, 
                        onSelect: (selectedDate) {
                          return context.read<UserProfileWriteProvider>().setBirthdate(selectedDate);
                        },
                      ),

                      const SizedBox(height: 25,),

                      //UserEducationEditList(userId: currentUser.docId)
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

}
