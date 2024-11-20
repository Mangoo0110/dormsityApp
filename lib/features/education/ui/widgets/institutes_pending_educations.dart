import 'package:dormsity/core/utils/routing/smooth_page_transition.dart';
import 'package:dormsity/features/education/ui/pages/education_approve_check.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/func/dekhao.dart';
import '../../../page_entity/domain/entities/institute_public.dart';
import '../providers/education_read_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../../domain/entities/education_private.dart';
import 'education_verify_preview_tile.dart';

class InstitutesPendingEducations extends StatefulWidget {
  final InstitutePub institutePub;
  const InstitutesPendingEducations({super.key, required this.institutePub});

  @override
  State<InstitutesPendingEducations> createState() => _InstitutesPendingEducationsState();
}

class _InstitutesPendingEducationsState extends State<InstitutesPendingEducations> {

  List<EducationPrv> educationsToVerify = [];

  bool allLoaded = false;

  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  Future<void> getPendings() async{
    dekhao("getPendings");
    setState(() {
      isLoading = true;
    });
    await context.read<EducationReadProvider>().institutePendingEducations(instituteDomain: widget.institutePub.domain ?? '').then((educations){
      if(educations.isEmpty || educations.length < 100) {
        allLoaded = true;
      }
      educationsToVerify.addAll(educations);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await getPendings();

    final listener = _scrollController.addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        getPendings();
      }
    });

    
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          color: Colors.transparent,
          child: ListView.builder(
            itemCount: educationsToVerify.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context, 
                        SmoothPageTransition().rightToLeft(
                          secondScreen: EducationApproveCheck(educationPrv: educationsToVerify[index])
                      ));
                    },
                    child: EducationVerifyPreviewTile(educationPrv: educationsToVerify[index],)
                    .animate()
                    .fadeIn(delay: Duration(milliseconds: index * 100), duration: const Duration(milliseconds: 200)),
                  ),
                  // Loading more indicator
                  if(index == educationsToVerify.length - 1 && !allLoaded) const Center(child: CircularProgressIndicator())
                ],
              );
            },
          ),
        );
      },
    );
  }
  
}


