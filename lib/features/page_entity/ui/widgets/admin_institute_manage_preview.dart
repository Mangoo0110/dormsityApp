import 'package:dormsity/core/utils/constants/app_colors.dart';
import 'package:dormsity/core/utils/constants/app_sizes.dart';
import 'package:dormsity/features/auth/ui/providers/auth_provider.dart';
import 'package:dormsity/features/image/ui/widgets/show_rect_image.dart';
import 'package:dormsity/features/page_entity/ui/providers/institute_page_read_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/func/dekhao.dart';

class AdminInstituteManagePreview extends StatefulWidget {
  const AdminInstituteManagePreview({super.key});

  @override
  State<AdminInstituteManagePreview> createState() =>
      _AdminInstituteManagePreviewState();
}

class _AdminInstituteManagePreviewState
    extends State<AdminInstituteManagePreview> {
  @override
  Widget build(BuildContext context) {
    dekhao("_AdminInstituteManagePreviewState");
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: context.read<InstitutePageReadProvider>()
              .fetchAdminInstitute(context.read<UserAuthProvider>().userAuth!),
          builder: (context, snapshot) {

            switch (snapshot.connectionState) {

              case ConnectionState.waiting || ConnectionState.none:
                return Container();
              case ConnectionState.done || ConnectionState.active:
                if(snapshot.hasData || snapshot.data != null){
                  dekhao("_AdminInstituteManagePreviewState has data");
                  final institute = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 100,
                      width: constraints.maxWidth,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.context(context).textColor),
                        borderRadius: AppSizes.mediumBorderRadius,
                        boxShadow: [
                          BoxShadow(color: AppColors.context(context).shadowColor, blurRadius: 8)
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ShowRectImage(imageUrl: institute.logoUrl, borderRadiusVal: 6, height: 60,),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(institute.pageName, style: Theme.of(context).textTheme.titleMedium,),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  dekhao("_AdminInstituteManagePreviewState is null");
                  return Container();
                }
              default:
                return Container();
                
            }
          },
        );
      },
    );
  }
}
