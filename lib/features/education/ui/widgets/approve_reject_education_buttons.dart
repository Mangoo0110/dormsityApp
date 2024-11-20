
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/ui/providers/auth_provider.dart';
import '../providers/education_inquiry_provider.dart';

///
/// **Warning::**
/// 
/// Wrap this widget with a SizedBox/Container with given height and width.
/// 
///Or it may create unbounded height or width error.
class ApproveRejectEducationButtons extends StatefulWidget {
  ///
  /// **Warning::**
  /// 
  /// Wrap this widget with a SizedBox/Container with given height and width.
  /// 
  ///Or it may create unbounded height or width error.
  
  const ApproveRejectEducationButtons({super.key,});

  @override
  State<ApproveRejectEducationButtons> createState() => _ApproveRejectEducationButtonsState();
}

class _ApproveRejectEducationButtonsState extends State<ApproveRejectEducationButtons> {
  EducationApproveStatus educationApproveStatus = EducationApproveStatus.inquiring;
  @override
  Widget build(BuildContext context) {

    educationApproveStatus = context.watch<EducationInquiryProvider>().educationApproveStatus;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if(educationApproveStatus == EducationApproveStatus.inquiring || educationApproveStatus == EducationApproveStatus.approving) 
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: educationApproveStatus == EducationApproveStatus.inquiring ? ((constraints.maxWidth / 2) - 2) : constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  borderRadius: AppSizes.mediumBorderRadius,
                  color: Colors.greenAccent.shade400
                ),
                child: InkWell(
                  borderRadius: AppSizes.mediumBorderRadius,
                  onTap: () {
                    if(context.read<UserAuthProvider>().userAuth == null) {
                      Fluttertoast.showToast(msg: "Need login.");
                      return;
                    }
                    context.read<EducationInquiryProvider>().approveEducation(userAuth: context.read<UserAuthProvider>().userAuth!);
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: educationApproveStatus == EducationApproveStatus.approving ? 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidgets(context).buttonMedium(buttonText: "Approving"),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FittedBox(child: CircularProgressIndicator(color: AppColors.context(context).textColor,)),
                              ),
                            ],
                          ) 
                          : TextWidgets(context).buttonMedium(buttonText: "Approve"),
                    ),
                  ),
                ),
              ),

            if(educationApproveStatus == EducationApproveStatus.inquiring || educationApproveStatus == EducationApproveStatus.disApproving) 
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transformAlignment: Alignment.centerRight,
                width: educationApproveStatus == EducationApproveStatus.inquiring ? ((constraints.maxWidth / 2) - 2) : constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  borderRadius: AppSizes.mediumBorderRadius,
                  border: Border.all(color: Colors.red)
                ),
                child: InkWell(
                  borderRadius: AppSizes.smallBorderRadius,
                  onTap: () {
                    context.read<EducationInquiryProvider>().disApproveEducation();
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: educationApproveStatus == EducationApproveStatus.disApproving ? 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidgets(context).buttonMedium(buttonText: "Disapproving"),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: FittedBox(child: CircularProgressIndicator(color: AppColors.context(context).textColor,)),
                              ),
                            ],
                          ) 
                          : TextWidgets(context).buttonMedium(buttonText: "Disapprove"),
                    ),
                  ),
                ),
              ),

            if(educationApproveStatus == EducationApproveStatus.done)
              AnimatedContainer(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  borderRadius: AppSizes.mediumBorderRadius,
                  border: Border.all(color: Colors.green)
                ),
                duration: const Duration(milliseconds: 100),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidgets(context).buttonMedium(buttonText: "Done", textColor: Colors.green),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.done, color: Colors.green,),
                      )
                    ],
                  ) 
                ),
              ),

            if(educationApproveStatus == EducationApproveStatus.failed)
              AnimatedContainer(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  borderRadius: AppSizes.mediumBorderRadius,
                  border: Border.all(color: Colors.yellow)
                ),
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidgets(context).buttonMedium(buttonText: "Failed",),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(Icons.error_outline, color: Colors.yellow,),
                      )
                    ],
                  ) 
                ),
              ),
          ],
        );
      },
    );
  }
}