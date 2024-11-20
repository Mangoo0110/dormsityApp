// import 'package:dormsity/core/utils/constants/app_colors.dart';
// import 'package:dormsity/core/utils/routing/smooth_page_transition.dart';
// import 'package:dormsity/features/hub/ui/pages/page_view.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../../institute_admin_dashboard.dart';
// import '../../../hub/domain/entities/page.dart';
// import '../widgets/floating_add_button.dart';
// import '../../../../core/utils/constants/app_sizes.dart';
// import '../../../image/ui/widgets/show_rect_image.dart';
// import '../providers/admin_mange_read_provider.dart';

// class ManagePage extends StatefulWidget {
//   const ManagePage({super.key});

//   @override
//   State<ManagePage> createState() => _ManagePageState();
// }

// class _ManagePageState extends State<ManagePage> {
  
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       backgroundColor: AppColors.context(context).contentBoxColor,
//       appBar: AppBar(
//         leadingWidth: 0,
//         title: Text("Manage(Admin)", style: Theme.of(context).textTheme.titleLarge,),
//       ),
//       floatingActionButton: const FloatingAddButton(),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 14.0, right: 6, top: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _instituteManagement(),
//             Padding(
//               padding: const EdgeInsets.only(top: 25.0),
//               child: _hubsManagement(),
//             )
//           ],
//         ),
//       ),
//     );
  
//   }

//   Widget _instituteManagement(){
//     if(context.read<AdminMangeReadProvider>().institutePrv == null) return Container();

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Manage institute", style: Theme.of(context).textTheme.titleMedium,),
//             const SizedBox(height: 10,),
//             Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                  Navigator.push(context, SmoothPageTransition().bottomToUp(secondScreen: InstituteAdminDashboard(institutePrv: context.read<AdminMangeReadProvider>().institutePrv!,)));
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       ShowRectImage(imageUrl: context.read<AdminMangeReadProvider>().institutePrv!.logoUrl , borderRadiusVal: 4, height: 50, width: 50,),
//                       Flexible(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 4.0),
//                           child: Text(context.read<AdminMangeReadProvider>().institutePrv!.institutionName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSizes.mediumTextSize), maxLines: 2,),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }


//   Widget _hubsManagement(){
//     List<DPage> isuueHubs = context.read<AdminMangeReadProvider>().hubsOfUserAsAdmin;
//     if(isuueHubs.isEmpty) return Container();

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text("Issue hubs", style: Theme.of(context).textTheme.titleMedium,),
//             const SizedBox(height: 10,),

//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: isuueHubs.length,
//               itemBuilder: (context, index) {
//                 return Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(context, SmoothPageTransition().bottomToUp(secondScreen: HubPageView(hub: isuueHubs[index])));
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: [
//                           ShowRectImage(imageUrl: isuueHubs[index].logoUrl , borderRadiusVal: 4, height: 50, width: 50,),
//                           Flexible(
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 4.0),
//                               child: Text(isuueHubs[index].pageName, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: AppSizes.mediumTextSize), maxLines: 2,),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             )
            
//           ],
//         );
//       },
//     );
//   }
// }