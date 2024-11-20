// import 'core/utils/constants/app_colors.dart';
// import 'features/channel/domain/entities/channel_private.dart';
// import 'features/channel/domain/entities/channel.dart.dart';
// import 'features/image/ui/widgets/show_rect_image.dart';
// import 'features/image/ui/widgets/show_round_image.dart';
// import 'features/page_entity/domain/entities/institute_public.dart';
// import 'verify_tab.dart';
// import 'package:flutter/material.dart';


// class PageAdminDashboard extends StatefulWidget {
//   final InstitutePub institutePub;
//   const PageAdminDashboard({super.key, required this.institutePub});

//   @override
//   State<PageAdminDashboard> createState() => _PageAdminDashboardState();
// }

// class _PageAdminDashboardState extends State<PageAdminDashboard> {

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return DefaultTabController(
//           length: 4,
//           child: Scaffold(
//             appBar: AppBar(
//               leading: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//               title: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   ShowRectImage(imageUrl: widget.institutePub.logoUrl, borderRadiusVal: 2, height: 40, width: 40,),
//                   Flexible(
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 6.0),
//                       child: FittedBox(
//                         child: Text(widget.institutePub.pageName),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               bottom: const TabBar(
//                 tabs: [
//                   Tab(text: "Verify"),
//                   Tab(text: "Channels"),
//                   Tab(text: "About"),
//                   Tab(text: "Settings"),
//                 ],
//               ),
//             ),
//             body: TabBarView(
//               children: [

//                 //verify rab   
//                 VerifyTab(institutePub: widget.institutePub,),  

//                 // channel tab
//                 const ChannelTab(),

//                 //about tab
//                 Container(color: Colors.orange[100]),
                
//                 // settings tab
//                 Container(color: Colors.green[100]),  // Settings tab content
//               ],
//             ),
//           ),
//         );
//       }
//     );
//   }
// }

// class ChannelTab extends StatefulWidget {
//   const ChannelTab({super.key});

//   @override
//   State<ChannelTab> createState() => _ChannelTabState();
// }

// class _ChannelTabState extends State<ChannelTab> {

//   List<Channel> channels = [];
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         return Scaffold(
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: AppColors.context(context).accentColor,
//             onPressed: () {
              
//             },
//             child: const Icon(Icons.add, ),
//           ),
//           body: ListView.builder(
//             itemCount: channels.length,
//             itemBuilder: (context, index) {
//               return InkWell(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ShowRoundImage(imageUrl: channels[index].logoUrl),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Text(channels[index].channelName),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           )
//         );
//       },
//     );
//   }
// }