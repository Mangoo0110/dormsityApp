
import '../../../../core/utils/constants/app_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/routing/smooth_page_transition.dart';
import '../../../auth/ui/providers/auth_provider.dart';
import '../../domain/entities/education_public.dart';
import 'package:flutter/material.dart';

import '../pages/add_edit_education.dart';
import '../providers/education_read_provider.dart';
import 'education_preview_tile.dart';

class UserEducationEditList extends StatefulWidget {
  final String userId;
  const UserEducationEditList({super.key, required this.userId});

  @override
  State<UserEducationEditList> createState() => _UserEducationEditListState();
}

class _UserEducationEditListState extends State<UserEducationEditList> {
  List<EducationPub> educations = [];

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await context.read<EducationReadProvider>().educationsOfUser(userId: widget.userId).then((list){
      educations = list;
      setState(() {
        
      });
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Educations", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.context(context).textColor.withOpacity(.6)),),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: AppSizes.smallBorderRadius,
                    color: AppColors.context(context).backgroundColor,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: AppSizes.smallBorderRadius,
                      splashColor: Colors.green.shade200,
                      onTap: () {
                        Navigator.push(context, SmoothPageTransition().rightToLeft(
                          secondScreen: AddEditEducation(
                            educationPrv: null, 
                            userId: context.read<UserAuthProvider>().userId)
                          )
                        ).then((_){
                          
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Add", style: Theme.of(context).textTheme.labelLarge,),
                            const SizedBox(width: 10,),
                            const Icon(Icons.add,),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15,),
            if(educations.isEmpty) _noEducation(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: educations.length,
              itemBuilder: (context, index) {
                final education = educations[index];
                return SizedBox(
                  width: constraints.maxWidth,
                  child: EducationPreviewTile(
                    educationPub: education,
                    deleteOption: true,
                  )
                );
              },
            ),
          ],
        );
        // return Material(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 15.0),
        //         child: Row(
        //           children: [
        //             Text("Education", style: Theme.of(context).textTheme.titleMedium,),
        //             const Padding(
        //               padding: EdgeInsets.only(left: 8.0),
        //               child: Icon(Icons.school),
        //             )
        //           ],
        //         ),
        //       ),
        //       if(educations.isEmpty) _noEducation(),
        //       ListView.builder(
        //         physics: const NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         itemCount: min(maxShow, educations.length),
        //         itemBuilder: (context, index) {
        //           return Padding(
        //             padding: const EdgeInsets.only(bottom: 4.0),
        //             child: EducationPreviewTile(educationPub:  educations[index]),
        //           );
        //         },
        //       ),
        //       if(educations.length > maxShow) _showAllButton(),
        //     ],
        //   ),
        // );
      },
    );
  }


  Widget _showAllButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(3),
      onTap: () {
      },
      child: TextWidgets(context).highLightedItalicText(text: "Show all ${educations.length} educations",)
    );
  }


  Widget _noEducation() {

    double boxHeight = 100;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: boxHeight,
          width: constraints.maxWidth,
          child: Align(
            alignment: Alignment.center,
            child: TextWidgets(context).highLightedItalicText(text: "No educations listed yet!", textColor: AppColors.context(context).textColor.withOpacity(.5)),
          )
        );
      },
    );
  }

}

