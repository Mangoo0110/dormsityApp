import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';

import '../../data/datasources/firebase/image_firebase_datasource.dart';
import '../providers/image_read_provider.dart';

class ShowRoundImage extends StatefulWidget {
  final String imageUrl;
  final double? radius;
  const  ShowRoundImage({super.key, required this.imageUrl, this.radius,});

  @override
  State<ShowRoundImage> createState() => _ShowRoundImageState();
}

class _ShowRoundImageState extends State<ShowRoundImage> {

  ImageX? image;

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if(!mounted || image != null) return;
    image = await context.read<ImageReadProvider>().fetchImage(imageUrl: widget.imageUrl);
    if(image != null) {
      setState(() {
      
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: widget.radius ?? constraints.maxHeight,
          width:  widget.radius ?? constraints.maxWidth,
          
          decoration: BoxDecoration(
            color: AppColors.context(context).textColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(8000000000),
          ),
          child: (image != null) ? _image(image!.image) : null
          
        );
      },
    );
  }

  Widget _image(Uint8List image){
    return LayoutBuilder(
      builder: (context, constraints) {
        return ClipOval(
          child: Image.memory(
            image,
            fit: BoxFit.cover,
            height: widget.radius ?? constraints.maxHeight - 2,
            width:  widget.radius ?? constraints.maxWidth - 2,
          ).animate().fadeIn(curve: Curves.easeInOutSine, duration: const Duration(milliseconds: 300)),
        );
      },
    );
  }

}

