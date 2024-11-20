import 'dart:math';

import '../../../../core/common/widgets/text_widgets.dart';
import '../../../../core/utils/constants/app_colors.dart';
import '../../domain/entities/work_public.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserWorkRoleList extends StatefulWidget {
  final List<WorkRolePub> workRoles;
  const UserWorkRoleList({super.key, required this.workRoles});

  @override
  State<UserWorkRoleList> createState() => _UserWorkRoleListState();
}

class _UserWorkRoleListState extends State<UserWorkRoleList> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int maxShow = 4;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Material(
          //color: AppColors.context(context).backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Text("Work-Role", style: Theme.of(context).textTheme.titleMedium,),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.home_work_rounded),
                    )
                  ],
                ),
              ),
              if(widget.workRoles.isEmpty) _noWorkRoles(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: min(maxShow, widget.workRoles.length),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: _workRole(widget.workRoles[index]),
                  );
                },
              ),
              if(widget.workRoles.length > maxShow) _showAllButton(),
            ],
          ),
        );
      },
    );
  }


  Widget _showAllButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(3),
      onTap: () {
      },
      child: TextWidgets(context).highLightedItalicText(text: "Show all ${widget.workRoles.length} work roles",)
    );
  }


  Widget _workRole(WorkRolePub workRole) {

    double boxHeight = 200;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: boxHeight,
          width: constraints.maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.context(context).contentBoxColor,
            boxShadow: [
              BoxShadow(color: AppColors.context(context).textColor)
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(workRole.institutionName, style: Theme.of(context).textTheme.titleMedium,),
              Text("${workRole.workRole}, ${workRole.department}", style: Theme.of(context).textTheme.titleMedium,),
              TextWidgets(context).highLightText(
                text: "${DateFormat.yMMM().format(workRole.startDate)} - ${workRole.endDate == null ? 'Present' : DateFormat.yMMM().format(workRole.endDate!)}",
              )
            ],
          ),
        );
      },
    );
  }

  Widget _noWorkRoles() {

    double boxHeight = 100;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: boxHeight,
          width: constraints.maxWidth,
          child: Align(
            alignment: Alignment.center,
            child: TextWidgets(context).highLightedItalicText(text: "No work roles listed yet!", textColor: AppColors.context(context).textColor.withOpacity(.5)),
          )
        );
      },
    );
  }

}

