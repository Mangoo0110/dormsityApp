
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_post_create_provider.dart';

class NewsPostTextInputWidget extends StatefulWidget {

  final String initialTextData;
  final Function(String textTheme) onChanged;
  const NewsPostTextInputWidget({
    super.key,
    required this.initialTextData,
    required this.onChanged,
  });

  @override
  State<NewsPostTextInputWidget> createState() => _NewsPostTextInputWidgetState();
}

class _NewsPostTextInputWidgetState extends State<NewsPostTextInputWidget> {

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
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: TextField(
            focusNode: _focusNode,
            controller: _controller,
            onTapOutside: (event) {
              _focusNode.unfocus();
            },           
            onChanged: (value) {
              context.read<NewsPostCreateProvider>().setTextContent(value);
              widget.onChanged(value);
            },
            keyboardType: TextInputType.multiline,
            maxLines: 100,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(right: 4, bottom: 6, top: 6),
              alignLabelWithHint: true,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: "Write about the news...",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none
            ),
          ),
        );
      
      },
    );
  }
}
