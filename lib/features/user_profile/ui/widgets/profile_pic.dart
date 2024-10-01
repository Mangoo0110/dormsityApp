// // import 'dart:math';

// import '../../../../core/utils/image/image_loader_func.dart';
// import '../../../admin_profile/ui/providers/edit_admin_provider.dart';
// import '../../../../cupertino.dart';
// import '../../../../material.dart';
// import '../../../../core/utils/constants/app_colors.dart';
// import '../../../image_feature/ui/widgets/upload_image.dart';
// import '../../../../widgets.dart';
// import '../../../../provider.dart';

// // class ProfilePic extends StatefulWidget {
// //   const ProfilePic({super.key});

// //   @override
// //   State<ProfilePic> createState() => _ProfilePicState();
// // }

// // class _ProfilePicState extends State<ProfilePic> {
  
// //   @override
// //   Widget build(BuildContext context) {

// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         return SizedBox(
// //           height: constraints.maxHeight,
// //           width: constraints.maxWidth,
// //           child: Stack(
// //             alignment: Alignment.topLeft,
// //             children: [
// //               ClipOval(
// //                 child: Container(
// //                   height: min(140, constraints.maxWidth ),
// //                   width: min(140, constraints.maxWidth),
// //                   decoration: BoxDecoration(
// //                     color: AppColors.context(context).textColor,
// //                     borderRadius: BorderRadius.circular(8000000)
// //                   ),
// //                   child: image == null 
// //                     ? Icon(
// //                         Icons.image, 
// //                         color: AppColors.context(context).textColor.withOpacity(.7), 
// //                         size: min(140, constraints.maxWidth / 2) - 6,
// //                       )
// //                     : Image.memory(image, fit: BoxFit.cover,),
// //                 ),
// //               ),
// //               Positioned(
// //                 bottom: 8,
// //                 left: min(140, constraints.maxWidth) - 40,
// //                 child: InkWell(
// //                   onTap: () async{
// //                     await pickImage().then((value) {
// //                       if(value != null) {
// //                         context.read<EditAdminProvider>().setProfilePic(value);
// //                       }
// //                     });
// //                   },
// //                   child: CircleAvatar(
// //                     backgroundColor: AppColors.context(context).backgroundColor,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(4.0),
// //                       child: CircleAvatar(
// //                         backgroundColor: AppColors.context(context).textColor,
// //                         child:  Padding(
// //                           padding: EdgeInsets.all(2.0),
// //                           child: Icon(
// //                             Icons.camera_alt,
// //                             color: AppColors.context(context).accentColor,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               )
// //               // SizedBox(
// //               //   height: 60,
// //               //   width: constraints.maxWidth / 2,
// //               //   child: Padding(
// //               //     padding: const EdgeInsets.only(right: 4.0),
// //               //     child: FittedBox(
// //               //       fit: BoxFit.scaleDown,
// //               //       child: UploadImage(
// //               //         onPick: (pickedImage) {
// //               //           context.read<EditAdminProvider>().setProfilePic(pickedImage);
// //               //         },
// //               //       ),
// //               //     ),
// //               //   ),
// //               // )
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// // }