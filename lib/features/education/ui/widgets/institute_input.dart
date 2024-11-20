import 'package:dormsity/core/common/widgets/text_widgets.dart';
import 'package:dormsity/core/utils/constants/app_colors.dart';
import 'package:dormsity/core/utils/routing/smooth_page_transition.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../image/ui/widgets/show_rect_image.dart';
import '../../../page_entity/ui/pages/search_institute.dart';
import '../providers/education_write_provider.dart';

class InstituteInput extends StatefulWidget {
  const InstituteInput({
    super.key,
  });

  @override
  State<InstituteInput> createState() => _InstituteInputState();
}

class _InstituteInputState extends State<InstituteInput> {

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {

    String hintText = " Ex: Boxton University";
    String labelText = "Institute*";
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText, style: TextStyle(color: AppColors.context(context).labelColor.withOpacity(.9)),),
        
            InkWell(
              onTap: () {
                Navigator.push(context, SmoothPageTransition().bottomToUp(
                  secondScreen: SearchInstitute(
                    onSelect: (institute){
                      context.read<EducationWriteProvider>().editInstitution(institute);
                      Navigator.pop(context);
                      setState(() {
                        
                      });
                    }, 
                  hintText: hintText, 
                  labelText: 'Institute'
                )));
              },
              child: SizedBox(
                //height: 45,
                width: constraints.maxWidth,
                child: context.read<EducationWriteProvider>().instituteName.isEmpty 
                  ? Align(
                    alignment: Alignment.bottomLeft,
                    child: TextWidgets(context).highLightText(text: hintText, textColor: AppColors.context(context).hintColor,),
                  )
                  : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: ShowRectImage(imageUrl: context.read<EducationWriteProvider>().institute?.logoUrl ?? '', borderRadiusVal: 4, width: 40, height: 40,),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(context.read<EducationWriteProvider>().instituteName, overflow: TextOverflow.ellipsis, maxLines: 2,),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: CloseButton(
                            onPressed: () {
                              
                            },
                          )
                        )
                      ],
                    ),
                  ),
              ),
            ),
        
            Container(
              height: 1,
              width: constraints.maxWidth,
              color: AppColors.context(context).textColor,
            )
          ],
        );
      
      },
    );
  }
}
