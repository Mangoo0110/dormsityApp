import 'dart:math';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../../image/ui/widgets/show_rect_image.dart';
import '../../domain/entities/education_public.dart';
import 'package:flutter/material.dart';

import '../providers/education_read_provider.dart';
import 'education_preview_tile.dart';

class UserEducationList extends StatefulWidget {
  final String userId;
  const UserEducationList({super.key, required this.userId});

  @override
  State<UserEducationList> createState() => _UserEducationListState();
}

class _UserEducationListState extends State<UserEducationList> {
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
    int maxShow = 4;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: educations.length,
          itemBuilder: (context, index) {
            final education = educations[index];
            return SizedBox(
              width: constraints.maxWidth,
              child: EducationPreviewTile(educationPub: education)
            );
          },
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

