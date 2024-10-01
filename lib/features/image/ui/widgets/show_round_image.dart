import 'dart:math';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';

import '../../domain/entities/image.dart';
import '../providers/app_image_provider.dart';

class ShowRoundImage extends StatefulWidget {
  final String imageId;
  final double? height;
  final double? width;
  const  ShowRoundImage({super.key, required this.imageId, this.height, this.width});

  @override
  State<ShowRoundImage> createState() => _ShowRoundImageState();
}

class _ShowRoundImageState extends State<ShowRoundImage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: widget.height ?? constraints.maxHeight,
          width:  widget.width ?? constraints.maxWidth,
          
          decoration: BoxDecoration(
            color: AppColors.context(context).textColor.withOpacity(.5),
            borderRadius: BorderRadius.circular(800000),
          ),
          child: FutureBuilder(
            future: context.read<AppImageProvider>().fetchImage(imageId: widget.imageId), 
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.done || ConnectionState.active:
                  if(snapshot.hasData){
                    ImageX? imageX = snapshot.data;
                    if(imageX != null) {
                      return _image(imageX.image);
                    } else {
                      return _icon();
                    }
                  } else {
                    return _icon();
                  }
                default: 
                  return const Center(child: CircularProgressIndicator());
              }
            },
              
          )
          
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
            height: widget.height ?? constraints.maxHeight - 2,
            width:  widget.width ?? constraints.maxWidth - 2,
          ),
        );
      },
    );
  }

  Widget _icon(){
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.image, 
            color: AppColors.context(context).textColor.withOpacity(.8), 
            size: min(widget.height ?? constraints.maxHeight, widget.width ?? constraints.maxWidth) - 8,),
        );
      },
    );
  }

}