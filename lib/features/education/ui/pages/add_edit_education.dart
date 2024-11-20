import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../widgets/academic_email_input.dart';
import '../widgets/contact_no_input.dart';
import '../widgets/degree_input.dart';

import '../widgets/create_education_save_button.dart';
import '../widgets/end_date_input.dart';
import '../widgets/start_date_input.dart';

import '../../../auth/ui/providers/auth_provider.dart';
import '../../domain/entities/education_private.dart';
import '../providers/education_write_provider.dart';
import '../widgets/institute_input.dart';
import '../widgets/studentid_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditEducation extends StatefulWidget {
  final EducationPrv? educationPrv;
  final String userId;
  const AddEditEducation({super.key, required this.educationPrv, required this.userId});

  @override
  State<AddEditEducation> createState() => _AddEditEducationState();
}

class _AddEditEducationState extends State<AddEditEducation> {

  void ifSavedPop(){
    if(context.watch<EducationWriteProvider>().saveStatus == SaveStatus.saved){
      dekhao("saveStatus == ${context.read<EducationWriteProvider>().saveStatus}");
      Future.delayed(const Duration(milliseconds: 1000)).then((_){
        if(mounted){
          Navigator.pop(context);
        }
      });
      
    }
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ifSavedPop();
  }

  @override
  void initState() {
    context.read<EducationWriteProvider>().init(currentUserId: context.read<UserAuthProvider>().userId);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.context(context).contentBoxColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CloseButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 8,),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            
                            Text("${widget.educationPrv == null ? "Add" : "Edit"} education", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),),
                            const SizedBox(
                              height: 10,
                            ),
                                        
                            Text("* Indicates required", style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic),),
                            const SizedBox(
                              height: 40,
                            ),
                                        
                            const Flexible(child: InstituteInput()),
                            const SizedBox(
                              height: 40,
                            ),
                            
                            const DegreeInput(),
                            const SizedBox(
                              height: 40,
                            ),
                                        
                            StudentIdInputWidget(
                              initialTextData: context.read<EducationWriteProvider>().studentID,  
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            AcademicEmailInput(
                              initialTextData: context.read<EducationWriteProvider>().email,  
                            ),
                            const SizedBox(
                              height: 40,
                            ),

                            ContactNoInput(
                              initialTextData: context.read<EducationWriteProvider>().contactNo,  
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                                        
                            const StartDateInput(),
                            const SizedBox(
                              height: 40,
                            ),
                                        
                            const EndDateInput(),
                        
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CreateEducationSaveButton()
          ],
        ),
      ),
    );
  }


  // Widget _institute(){
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       return 
  //     },
  //   );
  // }
}