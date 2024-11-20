import 'package:dormsity/core/utils/constants/app_colors.dart';
import 'package:dormsity/core/utils/constants/data_field_key_names.dart';

import '../../../../core/utils/enums/common_enums.dart';
import '../../../../core/utils/func/dekhao.dart';
import '../../../auth/data/datasources/remote/auth_remote_datasource.dart';
import '../../../image/ui/widgets/image_show_upload.dart';
import '../../domain/entities/institute_public.dart';
import '../providers/institute_page_create_provider.dart';
import '../widgets/save_institute_page_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/institute_input_widget.dart';

class CreateInstitutePage extends StatefulWidget {
  final InstitutePub? oldInstitutePub;
  final UserAuth userAuth;
  const CreateInstitutePage({super.key, required this.oldInstitutePub, required this.userAuth});

  @override
  State<CreateInstitutePage> createState() => _CreateInstitutePageState();
}

class _CreateInstitutePageState extends State<CreateInstitutePage> {

  final ScrollController _controller = ScrollController();

  void ifSavedPop(){
    if(context.watch<InstitutePageWriteProvider>().saveStatus == SaveStatus.saved){
      dekhao("saveStatus == ${context.read<InstitutePageWriteProvider>().saveStatus}");
      Future.delayed(const Duration(milliseconds: 1000)).then((_){
        if(mounted){
          Navigator.pop(context);
        }
      });
      
    }
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ifSavedPop();
  }

  @override
  void initState() {
    context.read<InstitutePageWriteProvider>().init(oldInstitutePrv: widget.oldInstitutePub, userAuth: widget.userAuth);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.context(context).contentBoxColor,
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    
      body: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 8),
        child: ListView(
          controller: _controller,
          shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text("${widget.oldInstitutePub == null ? "Create" : "Edit"} institute page", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),),
            const SizedBox(
              height: 10,
            ),
            Text("* Indicates required", style: Theme.of(context).textTheme.labelMedium?.copyWith(fontStyle: FontStyle.italic),),
                        
            const SizedBox(
              height: 40,
            ),
        
            _logoInput(),
        
            const SizedBox(
              height: 40,
            ),
                        
            _instituteName(),
            const SizedBox(
              height: 40,
            ),
        
            _domainName(),
            const SizedBox(
              height: 40,
            ),
            
            _address(),
            const SizedBox(
              height: 40,
            ),
        
            const SaveInstitutePageButton()
                        
          ],
        ),
      ),
    
    );
  }

  Widget _logoInput(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 140,
          width: constraints.maxWidth,
          child: ImageShowUpload(
            radius: 140, 
            imageUrl: null, collectionName: FirebaseStorageCollections.kPage, docId: context.read<InstitutePageWriteProvider>().docId,
          ),
        );
      },
    );
  }

  Widget _instituteName(){
    String hintText = "Ex: Boston University";
    String labelText = "Institute*";
    return InstituteTextInputWidget(
      hintText: hintText, 
      labelText: labelText, 
      suffixIcon: null, 
      initialTextData: context.read<InstitutePageWriteProvider>().instituteName,
      onChanged: (text) {
        context.read<InstitutePageWriteProvider>().setInstituteName(text);
      },
    );
  }

  Widget _domainName(){
    String hintText = "Ex: www.boston-university.uk";
    String labelText = "Domain*";
    return InstituteTextInputWidget(
      hintText: hintText, 
      labelText: labelText, 
      initialTextData: context.read<InstitutePageWriteProvider>().domain,  
      onChanged: (text) {
        context.read<InstitutePageWriteProvider>().setDomain(text);
      }, 
      suffixIcon: null,
    );
  }

  Widget _address(){
    String hintText = "Try to be detailed.";
    String labelText = "Address*";
    return InstituteTextInputWidget(
      hintText: hintText, 
      labelText: labelText, 
      suffixIcon: null, 
      initialTextData: context.read<InstitutePageWriteProvider>().address,  
      onChanged: (text){
        context.read<InstitutePageWriteProvider>().setAddress(text);
      },
    ); 
  }


  // Widget _institute(){
  //   return LayoutBuilder(
  //     builder: (context, constraints) {
  //       return 
  //     },
  //   );
  // }
}