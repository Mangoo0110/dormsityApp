
import 'package:flutter/material.dart';

class ChannelTextInputWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final Widget? suffixIcon;
  final String initialTextData;
  final Function(String textTheme) onChanged;
  const ChannelTextInputWidget({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.suffixIcon,
    required this.initialTextData,
    required this.onChanged,
  });

  @override
  State<ChannelTextInputWidget> createState() => _ChannelTextInputWidgetState();
}

class _ChannelTextInputWidgetState extends State<ChannelTextInputWidget> {

  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _controller.text = widget.initialTextData;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 70,
          width: constraints.maxWidth,
          child: TextField(
            focusNode: _focusNode,
            controller: _controller,
            onTapOutside: (event) {
              _focusNode.unfocus();
            },           
            onChanged: (value) {
              widget.onChanged(value);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(right: 4, bottom: 6, top: 6),
              suffixIcon: widget.suffixIcon,
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: widget.labelText,
              hintText: " ${widget.hintText}",
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
