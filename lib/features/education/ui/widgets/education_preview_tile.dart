

import '../../../../core/utils/classes/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../../init_dependency.dart';
import '../../../image/ui/widgets/show_rect_image.dart';
import '../../../page_entity/domain/usecases/fetch_by_domain.dart';
import '../../domain/entities/education_public.dart';

class EducationPreviewTile extends StatefulWidget {
  final EducationPub educationPub;
  final bool? deleteOption;
  final bool? editOption;
  const EducationPreviewTile({super.key, required this.educationPub, this.deleteOption, this.editOption});

  @override
  State<EducationPreviewTile> createState() => _EducationPreviewTileState();
}

class _EducationPreviewTileState extends State<EducationPreviewTile> {

  String imageUrl = '';

  Future<void> getInstituteLogoFromDomain() async{
    if(!widget.educationPub.institutionApproved) return;
    final domain = DomainUrl.tryParse(widget.educationPub.institutionDomain);
    if(domain != null) {
      dekhao("parsed institute domain. ${domain.url}");
      serviceLocator<FetchInstituteByDomain>().call(domain).then((lr) async{
        lr.fold(
          (l){

          }, 
          (institute) {
            dekhao("Parsed institute domain. ${institute.toString()}");
            
            setState(() {
              dekhao("Parsed institute domain 2. ${institute.toString()}");
              imageUrl = institute.logoUrl;
            });
          });
      });
  
    } else{
      dekhao("could not parse institute domain.");
    }
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await getInstituteLogoFromDomain();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return _education(widget.educationPub);
  }

  Widget _education(EducationPub education) {

    dekhao("Image url is $imageUrl");
    if(education.degree == null) return Container();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.school, color: AppColors.context(context).textColor.withOpacity(.6),),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      
                          // Institution name.
                          Text(
                            education.institutionName,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 2,
                          ),
                          // Degree and field of study.
                          Wrap(
                            spacing: 4,
                            children:
                              [
                                ...('${education.degree?.degree ?? ''}, ${education.degree?.fieldOfStudy ?? ''}').split(' ').map((word) {
                                  return Text(
                                    word,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic,),
                                    maxLines: 2,
                                  );
                                }),
                                
                              ]
                          ),
                          Row(
                            children: [
                              Icon(Icons.verified, color: education.institutionApproved ? Colors.blueAccent : AppColors.context(context).textGreyColor, size: 18,),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0, left: 8),
                                child: ShowRectImage(imageUrl: imageUrl, borderRadiusVal: 2, height: 30, width: 30,),
                              ),
                            ],
                          ),
                          // Education start date to end date
                          Text(
                            "${DateFormat.yMMM().format(education.startDate)} - ${education.endDate == null ? 'Present' : DateFormat.yMMM().format(education.endDate!)}",
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic, color: AppColors.context(context).textColor.withOpacity(.5)),
                          ),
                    
                          
                        ],
                      ),
                    ),
                    if(widget.deleteOption == true || widget.editOption == true ) Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   onTap: () {
                              
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(8.0),
                          //     child: Icon(Icons.edit, color: AppColors.context(context).textColor,),
                          //   )
                          // ),
                          //const SizedBox(width: 10,),
                          if (widget.deleteOption == true) InkWell(
                            onTap: () {
                              
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.delete, color: Colors.red.shade400, fill: 1,),
                                  Text("  Delete ", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.red.shade400),)
                                ],
                              ),
                            )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
        // return Container(
        //   //height: 100,
        //   width: constraints.maxWidth,
        //   decoration: BoxDecoration(
        //     //borderRadius: BorderRadius.circular(8),
        //     color: AppColors.context(context).backgroundColor,
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Padding(
        //       padding: const EdgeInsets.only(bottom: 8.0),
        //       child: Row(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.only(top: 4.0),
        //             child: ShowRectImage(imageUrl: imageUrl, borderRadiusVal: 2, height: 55, width: 55,),
        //           ),
        //           Flexible(
        //             child: Padding(
        //               padding: const EdgeInsets.only(left: 8.0),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
                          
        //                   Text(
        //                     education.institutionName,
        //                     style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
        //                     maxLines: 2,
        //                   ),
        //                   Wrap(
        //                     spacing: 4,
        //                     children:
        //                       [
        //                         ...('${education.degree?.degree ?? ''}, ${education.degree?.fieldOfStudy ?? ''}').split(' ').map((word) {
        //                           return Text(
        //                             word,
        //                             style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic,),
        //                             maxLines: 2,
        //                           );
        //                         }),
        //                         Icon(Icons.verified, color: education.institutionApproved ? Colors.blueAccent : AppColors.context(context).textGreyColor, size: 18,),
        //                       ]
        //                   ),
        //                   Text(
        //                     "${DateFormat.yMMM().format(education.startDate)} - ${education.endDate == null ? 'Present' : DateFormat.yMMM().format(education.endDate!)}",
        //                     style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic, color: AppColors.context(context).textColor.withOpacity(.5)),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
      },
    );
  }

  

}