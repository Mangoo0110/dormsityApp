import 'package:dormsity/core/common/widgets/text_widgets.dart';
import 'package:dormsity/core/utils/constants/app_colors.dart';
import 'package:dormsity/core/utils/routing/smooth_page_transition.dart';
import 'package:dormsity/features/education/ui/pages/search_degree_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/education_write_provider.dart';

class DegreeInput extends StatefulWidget {
  const DegreeInput({
    super.key,
  });

  @override
  State<DegreeInput> createState() => _DegreeInputState();
}

class _DegreeInputState extends State<DegreeInput> {

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

    String hintText = " Ex: Bachelor in science";
    String labelText = "Degree*";
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(labelText, style: TextStyle(color: AppColors.context(context).labelColor.withOpacity(.9)),),
        
            InkWell(
              onTap: () {
                if(context.read<EducationWriteProvider>().institute == null) {
                  Fluttertoast.showToast(msg: "Before selecting a degree, you nedd to select an institution.");
                  return;
                }
                Navigator.push(context, SmoothPageTransition().bottomToUp(
                  secondScreen: SearchDegreePage(
                    onSelect: (degree){
                      context.read<EducationWriteProvider>().editDegree(degree);
                      Navigator.pop(context);
                      setState(() {
                        
                      });
                    }, 
                  hintText: hintText, 
                  labelText: 'Degree'
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
                        Flexible(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("${context.read<EducationWriteProvider>().degree?.degree} in ${context.read<EducationWriteProvider>().degree?.fieldOfStudy}", overflow: TextOverflow.ellipsis, maxLines: 2,),
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
