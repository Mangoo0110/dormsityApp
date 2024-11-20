import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_post_create_provider.dart';



class PostNewsButton extends StatefulWidget {
  const PostNewsButton({super.key});

  @override
  State<PostNewsButton> createState() => _PostNewsButtonState();
}

class _PostNewsButtonState extends State<PostNewsButton> {

  ifDonePop() {
    if(context.watch<NewsPostCreateProvider>().saveStatus == SaveStatus.saved) {
      Future.delayed(const Duration(milliseconds: 800)).then((_){
        if(mounted) Navigator.pop(context);
      });
      
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    ifDonePop();
    super.didChangeDependencies();
  }

  SaveStatus saveStatus = SaveStatus.canNotSave;

  @override
  Widget build(BuildContext context) {

    saveStatus = context.watch<NewsPostCreateProvider>().saveStatus;
    dekhao("saveStatus == $saveStatus");
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7000000000),
            color: saveStatus == SaveStatus.canNotSave 
                ? AppColors.context(context).textColor.withOpacity(.5) 
                : saveStatus == SaveStatus.canSave || saveStatus == SaveStatus.saving
                ? AppColors.context(context).accentColor
                : saveStatus == SaveStatus.saved
                ? Colors.greenAccent.shade400
                : AppColors.context(context).contentBoxGreyColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
            child: InkWell(
              borderRadius: BorderRadius.circular(7000000000),
              onTap: () async{
                dekhao("Tapped Create button. Save status is ${saveStatus.name}");
            
                if(context.read<NewsPostCreateProvider>().saveStatus != SaveStatus.canSave) {
                  Fluttertoast.showToast(msg: "Please fill all the required fields.");
                  return;
                }
                if(saveStatus == SaveStatus.canSave) {
                  await context.read<NewsPostCreateProvider>().createPost(
                    saveImageReturnUrl: () async{ 
                      return <String>[];
                     });
                }
            
                if(saveStatus == SaveStatus.saved) Fluttertoast.showToast(msg: 'Saved already!');
              },
              child: Center(
                child: saveStatus == SaveStatus.canNotSave 
                  ? Text("Post", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor.withOpacity(.5)),).animate().fadeIn(duration: const Duration(milliseconds: 300))
                  : saveStatus == SaveStatus.canSave 
                  ? Text("Post", style: Theme.of(context).textTheme.labelLarge).animate().fadeIn(duration: const Duration(milliseconds: 300))
                  : saveStatus == SaveStatus.saving 
                  ? const CircularProgressIndicator() 
                  : saveStatus == SaveStatus.saved 
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Saved", style: Theme.of(context).textTheme.labelLarge),
                       const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.verified_sharp,),
                      )
                    ],
                  ).animate().fadeIn(duration: const Duration(milliseconds: 300))
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Failed", style: Theme.of(context).textTheme.labelLarge),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.error, color: Colors.yellow,),
                      )
                    ],
                  ).animate().fadeIn(duration: const Duration(milliseconds: 300))
                  
              ),
            ),
          ),
        );
      },
    );
  }
}