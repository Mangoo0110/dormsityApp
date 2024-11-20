import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../providers/channel_create_provider.dart';



class ChannelCreateUpdateButton extends StatefulWidget {
  const ChannelCreateUpdateButton({super.key});

  @override
  State<ChannelCreateUpdateButton> createState() => _ChannelCreateUpdateButtonState();
}

class _ChannelCreateUpdateButtonState extends State<ChannelCreateUpdateButton> {

  SaveStatus saveStatus = SaveStatus.canNotSave;

  

  @override
  Widget build(BuildContext context) {

    saveStatus = context.watch<ChannelCreateProvider>().saveStatus;
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
            onTap: () {
              if(saveStatus == SaveStatus.canSave) {
                context.read<ChannelCreateProvider>().createChannel();
                
              }

              if(saveStatus == SaveStatus.saved) Fluttertoast.showToast(msg: 'Saved is done already!');
            },
            child: Center(
              child: saveStatus == SaveStatus.canNotSave 
                ? TextWidgets(context).buttonMedium(buttonText: "Create", textColor: AppColors.context(context).textGreyColor).animate().fadeIn(duration: const Duration(milliseconds: 300))
                : saveStatus == SaveStatus.canSave 
                ? TextWidgets(context).buttonMedium(buttonText: "Create", textColor: AppColors.context(context).accentColor).animate().fadeIn(duration: const Duration(milliseconds: 300))
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