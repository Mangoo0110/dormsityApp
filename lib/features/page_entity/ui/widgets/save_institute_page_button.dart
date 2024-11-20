import 'package:dormsity/features/image/ui/providers/image_write_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../providers/institute_page_create_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SaveInstitutePageButton extends StatefulWidget {
  const SaveInstitutePageButton({super.key});

  @override
  State<SaveInstitutePageButton> createState() => _SaveInstitutePageButtonState();
}

class _SaveInstitutePageButtonState extends State<SaveInstitutePageButton> {

  SaveStatus saveStatus = SaveStatus.canNotSave;

  @override
  Widget build(BuildContext context) {

    saveStatus = context.watch<InstitutePageWriteProvider>().saveStatus;
    dekhao("saveStatus == $saveStatus");
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 50,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7000000000),
            
            border: Border.all(
              color: saveStatus == SaveStatus.canNotSave 
                ? AppColors.context(context).textGreyColor 
                : saveStatus == SaveStatus.canSave || saveStatus == SaveStatus.saving
                ? AppColors.context(context).accentColor
                : saveStatus == SaveStatus.saved
                ? Colors.greenAccent.shade400
                : Colors.red, width: 2)
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(7000000000),
            onTap: () {
              dekhao("Tapped Create-Institute button. Save status is ${saveStatus.name}");
              if(context.read<ImageWriteProvider>().image == null) {
                Fluttertoast.showToast(msg: "Please select a logo for the page.");
                return;
              }

              if(context.read<InstitutePageWriteProvider>().saveStatus != SaveStatus.canSave) {
                Fluttertoast.showToast(msg: "Please fill all the required fields.");
                return;
              }
              if(saveStatus == SaveStatus.canSave) {
                if(context.read<ImageWriteProvider>().image != null && context.read<ImageWriteProvider>().referencePath != null) {
                  context.read<ImageWriteProvider>().saveImage().then((url){
                    if(url != null) {
                      if(context.mounted) {
                        context.read<InstitutePageWriteProvider>().setLogoUrl(url);
                        context.read<InstitutePageWriteProvider>().saveInstitute();
                      }
                    }
                  });
                } else {
                  dekhao("Can not save image");
                }
                
              }

              if(saveStatus == SaveStatus.saved) Fluttertoast.showToast(msg: 'Saved already!');
            },
            child: Center(
              child: saveStatus == SaveStatus.canNotSave 
                ? TextWidgets(context).buttonMedium(buttonText: "Create Institute", textColor: AppColors.context(context).textGreyColor).animate().fadeIn(duration: const Duration(milliseconds: 300))
                : saveStatus == SaveStatus.canSave 
                ? TextWidgets(context).buttonMedium(buttonText: "Create Institute", textColor: AppColors.context(context).accentColor).animate().fadeIn(duration: const Duration(milliseconds: 300))
                : saveStatus == SaveStatus.saving 
                ? const CircularProgressIndicator() 
                : saveStatus == SaveStatus.saved 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidgets(context).buttonMedium(buttonText: "Saved", textColor: Colors.greenAccent.shade400),
                     Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.verified_sharp, color: Colors.greenAccent.shade400,),
                    )
                  ],
                ).animate().fadeIn(duration: const Duration(milliseconds: 300))
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidgets(context).buttonMedium(buttonText: "Failed", textColor: Colors.red.shade400),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.error, color: Colors.yellow,),
                    )
                  ],
                ).animate().fadeIn(duration: const Duration(milliseconds: 300))
                
            ),
          ),
        );
      },
    );
  }
}