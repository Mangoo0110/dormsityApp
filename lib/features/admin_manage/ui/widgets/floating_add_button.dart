import '../../../../core/utils/constants/app_colors.dart';
import '../../../../core/utils/routing/smooth_page_transition.dart';
import '../../../auth/ui/providers/auth_provider.dart';
import '../../../channel/ui/pages/create_channel_screen.dart';
import '../../../education/ui/pages/add_edit_education.dart';
import '../../../page_entity/ui/pages/create_institute_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FloatingAddButton extends StatefulWidget {
  const FloatingAddButton({super.key});

  @override
  State<FloatingAddButton> createState() => _FloatingAddButtonState();
}

class _FloatingAddButtonState extends State<FloatingAddButton> {

  // bool _tappedPlus = false;

  // FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Hero(
        tag: "bb",
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              
              Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                barrierDismissible: true,
                transitionDuration: const Duration(milliseconds: 400),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (BuildContext context, b, e) {
                  return  FloatingActions(
                    // onAddEducation: () {
                    //   Navigator.push(context, SmoothPageTransition().rightToLeft(
                    //     secondScreen: AddEditEducation(
                    //       educationPrv: null, 
                    //       userId: context.read<UserAuthProvider>().userId)
                    //     )
                    //   ).then((_){
                    //     if(context.mounted) {
                    //       Navigator.pop(context);
                    //     }
                    //   });
                      
                    // },

                    onCreateHub: () {
                      // Navigator.push(context, SmoothPageTransition().rightToLeft(
                      //   secondScreen: const CreateHubPage(
                      //     existingHub: null, 
                      //     instituteDomain: null)
                      //   )
                      // ).then((_){
                      //   if(context.mounted) {
                      //     Navigator.pop(context);
                      //   }
                      // });
                      
                    },
                    // onAddWorkRole: () {
                    //   Navigator.pop(context);
                    //   // Future.delayed(const Duration(milliseconds: 300));
                    //   // Navigator.push(context, SmoothPageTransition().rightToLeft(
                    //   //   secondScreen: AddEditEducation(
                    //   //     educationPrv: null, 
                    //   //     userId: context.read<UserAuthProvider>().userId)
                    //   //   )
                    //   // );
                    // },
                    onCreatePage: () {
                      if(context.read<UserAuthProvider>().userAuth == null) {
                        Fluttertoast.showToast(msg: "User is not authorized!");
                        if(context.mounted) {
                          Navigator.pop(context);
                        }
                        return;
                      }
                      Navigator.push(context, SmoothPageTransition().rightToLeft(
                        secondScreen: CreateInstitutePage(oldInstitutePub: null, userAuth: context.read<UserAuthProvider>().userAuth!,)
                      )).then((_){
                        if(context.mounted) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  );
                }));
              
            },
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.context(context).accentColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Icon(Icons.add, color: AppColors.context(context).contentBoxColor, size: 30,),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FloatingActions extends StatelessWidget {
  final VoidCallback onCreatePage;
  final VoidCallback onCreateHub;
  const FloatingActions({super.key, required this.onCreatePage, required this.onCreateHub});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Material(
          color: AppColors.context(context).backgroundColor.withOpacity(.5),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 80,
                left: 30,
                right: 30,
                child: Hero(
                  tag: "bb",
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Material(
                      color: AppColors.context(context).accentColor.withOpacity(1),
                      elevation: 24,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            // InkWell(
                            //   onTap: () {
                            //     HapticFeedback.mediumImpact();
                            //     onAddEducation();
                            //   },
                            //   borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                            //   child: _tile(iconData: Icons.school, label: "Add education",),
                            // ),

                            // Container(height: .4, width: double.infinity, color: AppColors.context(context).contentBoxColor,),
                            // InkWell(
                            //   onTap: () {
                            //     HapticFeedback.mediumImpact();
                            //     onAddWorkRole();
                            //   },
                            //   child: _tile(iconData: Icons.home_work, label: "Add work-role"),
                            // ),
                            
                            Container(height: .4, width: double.infinity, color: AppColors.context(context).contentBoxColor,),
                            InkWell(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                onCreatePage();
                              },
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                              child: _tile(iconData: Icons.space_dashboard_outlined, label: "Create page",)
                            ),

                            Container(height: .4, width: double.infinity, color: AppColors.context(context).contentBoxColor,),
                            InkWell(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                onCreatePage();
                              },
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                              child: _tile(iconData: Icons.signal_cellular_alt_rounded, label: "Create hub",)
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  
  }

  Widget _tile({required IconData iconData, required String label}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 40,
                      child: Stack(
                        children: [
                          Icon(iconData, size: 28, color: AppColors.context(context).contentBoxColor),
                          Positioned(
                            bottom: 1,
                            right: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                backgroundBlendMode: BlendMode.src,
                                color: AppColors.context(context).contentBoxColor,
                                borderRadius: BorderRadius.circular(800000000),
                                border: Border.all(color: AppColors.context(context).accentColor, width: 2)
                              ),
                              child: Icon(
                                Icons.add, 
                                size: 18,
                                color: AppColors.context(context).accentColor,
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.context(context).contentBoxColor),)
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}