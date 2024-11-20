// import 'core/utils/constants/app_colors.dart';
// import 'package:flutter/material.dart';

// import 'features/education/ui/widgets/institutes_pending_educations.dart';
// import 'features/page_entity/domain/entities/institute_private.dart';
// import 'features/page_entity/domain/entities/institute_public.dart';
// import 'features/work_role/domain/entities/work_private.dart';
// enum VerifyingTab {education, workRole}
// class VerifyTab extends StatefulWidget {
//   final InstitutePub institutePub;
//   const VerifyTab({super.key, required this.institutePub});

//   @override
//   State<VerifyTab> createState() => _VerifyTabState();
// }

// class _VerifyTabState extends State<VerifyTab> {

//   VerifyingTab _verifyingTab = VerifyingTab.education;

  
//   List<WorkRolePrv> workRolesToVerify = [];


//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           backgroundColor: AppColors.context(context).contentBoxColor,
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               _selectEducationOrWorkRole(),
              
//               Flexible(child: InstitutesPendingEducations(institutePub: widget.institutePub))
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _selectEducationOrWorkRole(){
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Row(
//           children: [
          
//           // Education tab selector.
//             Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _verifyingTab == VerifyingTab.education ?
//                     AppColors.context(context).textColor
//                     :
//                     Colors.transparent,
//                   border: Border.all(color: AppColors.context(context).textColor),
//                   borderRadius: BorderRadius.circular(600000000)
//                 ),
//                 child: InkWell(
//                   borderRadius:  BorderRadius.circular(600000000),
//                   onTap: () {
//                     _verifyingTab = VerifyingTab.education;
//                     setState(() {
                      
//                     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Education", 
//                       style: Theme.of(context).textTheme
//                         .labelLarge?.copyWith(
//                           color: _verifyingTab == VerifyingTab.education ?
//                             AppColors.context(context).contentBoxColor
//                             :
//                             AppColors.context(context).textColor,
//                         ),
//                       ),
//                   ),
//                 ),
//               ),
//             ),
        
//           // Work-Role tab selector.
//             Padding(
//               padding: const EdgeInsets.all(4.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: _verifyingTab == VerifyingTab.workRole ?
//                     AppColors.context(context).textColor
//                     :
//                     Colors.transparent,
//                   border: Border.all(color: AppColors.context(context).textColor),
//                   borderRadius: BorderRadius.circular(600000000)
//                 ),
//                 child: InkWell(
//                   borderRadius:  BorderRadius.circular(600000000),
//                   onTap: () {
//                     _verifyingTab = VerifyingTab.workRole;
//                     setState(() {
                      
//                     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Work-role", 
//                       style: Theme.of(context).textTheme
//                         .labelLarge?.copyWith(
//                           color: _verifyingTab == VerifyingTab.workRole ?
//                             AppColors.context(context).contentBoxColor
//                             :
//                             AppColors.context(context).textColor,
//                         ),
//                       ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }