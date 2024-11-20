import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/education_write_provider.dart';

class AcademicEmailInput extends StatefulWidget {
  final String initialTextData;
  const AcademicEmailInput({
    super.key,
    required this.initialTextData,
  });

  @override
  State<AcademicEmailInput> createState() => _AcademicEmailInputState();
}

class _AcademicEmailInputState extends State<AcademicEmailInput> {

  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    String hintText = "Institute provided unique email";
    String labelText = "Academic email";
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 70,
          width: constraints.maxWidth,
          child: TextField(
            onTapOutside: (event){
                _focusNode.unfocus();
            },
            focusNode: _focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 4, bottom: 6, top: 6),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: labelText,
              hintText: " $hintText",
              // enabledBorder: const UnderlineInputBorder(),
              // focusedBorder: const UnderlineInputBorder(),
              // border: const UnderlineInputBorder(),
              // disabledBorder: const UnderlineInputBorder()
            ),
            onChanged: (value) {
              context.read<EducationWriteProvider>().editEmail(value);
            },
          ),
        );
      
      },
    );
  }
}
