import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../user_profile/ui/widgets/user_image_name_preview_tile.dart';
import '../../domain/entities/education_private.dart';
import '../providers/education_inquiry_provider.dart';
import '../widgets/approve_reject_education_buttons.dart';

class EducationApproveCheck extends StatefulWidget {
  final EducationPrv educationPrv;
  const EducationApproveCheck({super.key, required this.educationPrv});

  @override
  State<EducationApproveCheck> createState() => _EducationApproveCheckState();
}

class _EducationApproveCheckState extends State<EducationApproveCheck> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(context.read<EducationInquiryProvider>().educationApproveStatus == EducationApproveStatus.done) {
      Future.delayed(const Duration(milliseconds: 600)).then((_){
        if(mounted) Navigator.pop(context);
      });
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    context.read<EducationInquiryProvider>().init(widget.educationPrv);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final education = widget.educationPrv;
    if(education.degree == null) return Container();
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.context(context).contentBoxColor,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                  
                      const SizedBox(
                        height: 40,
                      ),
                  
                      Row(
                        children: [
                          CloseButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text("Verify education", style: Theme.of(context).textTheme.titleLarge,),
                          ),
                        ],
                      ),
                  
                      
                      const SizedBox(
                        height: 30,
                      ),
                
                      Container(
                        color: AppColors.context(context).backgroundColor,
                        child: Column(
                          children: [
                            UserImageNamePreviewTile(userId: widget.educationPrv.userId, userName: widget.educationPrv.userName, ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${education.degree?.degree ?? ''}, ${education.degree?.fieldOfStudy ?? ''}',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic,),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    "${DateFormat.yMMM().format(education.startDate)} - ${education.endDate == null ? 'Present' : DateFormat.yMMM().format(education.endDate!)}",
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic, color: AppColors.context(context).textColor.withOpacity(.5)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      
                  
                      const SizedBox(
                        height: 30,
                      ),
                  
                      Text(
                        "Academic details",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                  
                      const SizedBox(
                        height: 15,
                      ),
                  
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Academic email", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor.withOpacity(.6)),),
                              InkWell(
                                onTap: () async{
                                  await Clipboard.setData(ClipboardData(text: education.email)).then((_){
                                    HapticFeedback.mediumImpact();
                                    Fluttertoast.showToast(msg: 'Academic email is copied.');
                                  });
                                  
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.copy,
                                    color: AppColors.context(context).textColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(education.email, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor),),
                  
                          const SizedBox(
                            height: 15,
                          ),
                  
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Student id", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor.withOpacity(.6)),),
                              InkWell(
                                onTap: () async{
                                  await Clipboard.setData(ClipboardData(text: education.studentId)).then((_){
                                    HapticFeedback.mediumImpact();
                                    Fluttertoast.showToast(msg: 'Student id is copied.');
                                  });
                                  
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(
                                    Icons.copy,
                                    color: AppColors.context(context).textColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Text(education.studentId, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).textColor),),
                          
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        
                SizedBox(
                  height: 60,
                  width: constraints.maxWidth,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6),
                    child: ApproveRejectEducationButtons(),
                  )
                )
              ],
            ),
          ),
        );
      }
    );
  }
  
}