

import 'package:dormsity/features/user_profile/ui/widgets/user_image_name_preview_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../domain/entities/education_private.dart';

class EducationVerifyPreviewTile extends StatefulWidget {
  final EducationPrv educationPrv;
  const EducationVerifyPreviewTile({super.key, required this.educationPrv});

  @override
  State<EducationVerifyPreviewTile> createState() => _EducationVerifyPreviewTileState();
}

class _EducationVerifyPreviewTileState extends State<EducationVerifyPreviewTile> {

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final education = widget.educationPrv;

    if(education.degree == null) return Container();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            children: [
              UserImageNamePreviewTile(userId: widget.educationPrv.userId, userName: widget.educationPrv.userName,),
              
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
        );
      },
    );
  }

}
