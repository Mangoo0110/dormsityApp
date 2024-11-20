import 'package:dormsity/core/utils/enums/page_enums.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/channel_create_provider.dart';

class SelectChannelType extends StatefulWidget {
  const SelectChannelType({super.key});

  @override
  State<SelectChannelType> createState() => _SelectChannelTypeState();
}

class _SelectChannelTypeState extends State<SelectChannelType> {
  ChannelType selectedChannelType = ChannelType.news;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ChannelType>(
      value: selectedChannelType,
      hint: Text("Select Channel Type", style: Theme.of(context).textTheme.titleMedium,),
      onChanged: (ChannelType? newValue) {
        setState(() {
          selectedChannelType = newValue!;
          context.read<ChannelCreateProvider>().setChannelType(selectedChannelType);
        });
      },
      items: ChannelType.values
          .where((type) => type != ChannelType.none) // Filter out 'none'
          .map((ChannelType type) {
            return DropdownMenuItem<ChannelType>(
              value: type,
              child: Text(type.name.toUpperCase()), // Display the enum name as text
            );
          })
          .toList(),
    );
  }
}