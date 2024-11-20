import '../providers/education_write_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/widgets/mmyyyy_picker.dart';

class StartDateInput extends StatefulWidget {
  const StartDateInput({
    super.key,
  });

  @override
  State<StartDateInput> createState() => _StartDateInputState();
}

class _StartDateInputState extends State<StartDateInput> {

  final FocusNode _focusNode = FocusNode();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textEditingController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    _textEditingController.text = context.read<EducationWriteProvider>().startDate;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 70,
          width: constraints.maxWidth,
          child: TextField(
            focusNode: _focusNode,
            readOnly: true,
            controller: _textEditingController,
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                barrierDismissible: true,
                transitionDuration: const Duration(milliseconds: 400),
                reverseTransitionDuration: const Duration(milliseconds: 400),
                pageBuilder: (BuildContext context, b, e) {
                  return  MmyyyyPicker(
                    initialDateTime: DateTime.now(),
                    onSelect: (pickedDate) {

                      context.read<EducationWriteProvider>().editStartDate(pickedDate);
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 100)).then((_){
                        setState(() {
                          
                        });
                      });

                    },
                  );
                }));
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(right: 4, bottom: 6, top: 6),
              suffixIcon: Icon(Icons.calendar_month),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Start date*',
              hintText: "",
              // enabledBorder: const UnderlineInputBorder(),
              // focusedBorder: const UnderlineInputBorder(),
              // border: const UnderlineInputBorder(),
              // disabledBorder: const UnderlineInputBorder()
            ),
          ),
        );
      
      },
    );
  }
}
