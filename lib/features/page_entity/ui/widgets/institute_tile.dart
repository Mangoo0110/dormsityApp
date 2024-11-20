import '../providers/institute_page_read_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';

class InstituteTile extends StatefulWidget {
  final UserAuth userauth;
  const InstituteTile({super.key, required this.userauth});

  @override
  State<InstituteTile> createState() => _InstituteTileState();
}

class _InstituteTileState extends State<InstituteTile> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
          future: context.read<InstitutePageReadProvider>().fetchAdminInstitute(widget.userauth), 
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active || ConnectionState.done:

                if(snapshot.hasData){
                  return SizedBox   (
                    height: 50,
                    width: constraints.maxWidth,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Manage institute",)
                    ),
                  );
                } else{
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