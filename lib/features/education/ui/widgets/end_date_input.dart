import 'package:dormsity/features/education/ui/providers/education_write_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/common/widgets/mmyyyy_picker.dart';

class EndDateInput extends StatefulWidget {
  const EndDateInput({
    super.key,
  });

  @override
  State<EndDateInput> createState() => _EndDateInputState();
}

class _EndDateInputState extends State<EndDateInput> {

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
    _textEditingController.text = context.read<EducationWriteProvider>().endDate;
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

                      context.read<EducationWriteProvider>().editEndDate(pickedDate);
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 100)).then((_){
                        setState(() {
                          
                        });
                      });

                    },
                  );
                }));
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 4, bottom: 6, top: 6),
              suffixIcon: const Icon(Icons.calendar_month),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'End date ${_textEditingController.text.isEmpty ? '(Expected)' : ''}',
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
