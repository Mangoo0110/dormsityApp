import 'package:dormsity/core/utils/classes/domain.dart';
import 'package:dormsity/features/education/ui/providers/education_write_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../domain/entities/degree_field_of_study.dart';
import '../providers/education_read_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';


class SearchDegreePage extends StatefulWidget {
  final Function(Degree institute) onSelect;
  final String hintText;
  final String labelText;
  const SearchDegreePage({super.key, required this.onSelect, required this.hintText, required this.labelText});

  @override
  State<SearchDegreePage> createState() => _SearchDegreePageState();
}

class _SearchDegreePageState extends State<SearchDegreePage> {

  final FocusNode _focusNode = FocusNode(); 
  final TextEditingController _searchInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Degree> searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    // context.read<InstitutePageReadProvider>().searchClear();
    // context.read<InstitutePageReadProvider>().searchByName("");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _search("");
    // _scrollController.addListener((){
    //   _scrollController.position.
    // });
  }

  Future<void> _search(String text) async{
    DomainUrl? domain =  DomainUrl.tryParse(context.read<EducationWriteProvider>().institute?.domain ?? '');
    if(domain == null) {
      Fluttertoast.showToast(msg: "Institute domain parse failed");
      return;
    }
    await context.read<EducationReadProvider>().searchDegree(text: text, instituteDomain: domain).then((degrees){
      searchResult = degrees;
      if(searchResult.isNotEmpty) {
        setState(() {
          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text("Select a degree", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.context(context).textGreyColor),)
          ),
          body: ListView.builder(
            //shrinkWrap: true,
            controller: _scrollController,
            //physics: const NeverScrollableScrollPhysics(),
            itemCount: searchResult.length,
            itemBuilder: (context, index) {
              final degree = searchResult[index];
              return Column(
                children: [
                  Container(
                    color: AppColors.context(context).dividerColor,
                    width: constraints.maxWidth,
                    height: index == 0 ? 1 : 0,
                  ),
                        
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                    child: InkWell(
                      onTap: () {
                        widget.onSelect(degree);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.school),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: FittedBox(
                                    child: Text(degree.degree, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium,)
                                  ),
                                ),
                              )
                            ],
                          ),
                        
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.menu_book),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: FittedBox(
                                    child: Text(degree.fieldOfStudy, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium,)
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                        
                  Container(
                    color: AppColors.context(context).dividerColor,
                    width: constraints.maxWidth,
                    height: 1,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _searchInput() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 80,
          width: constraints.maxWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
            
              onTapOutside: (event){
                _focusNode.unfocus();
              },
              focusNode: _focusNode,
              maxLines: 1,
              controller: _searchInputController,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                fillColor: AppColors.context(context).contentBoxColor,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                alignLabelWithHint: false,
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                hintText: widget.hintText,
                labelStyle: Theme.of(context).textTheme.titleMedium,
                hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                // border: const UnderlineInputBorder(),
                // enabledBorder: const UnderlineInputBorder(),
                // focusedBorder: const UnderlineInputBorder(),
              ),
              onChanged: (value) async{
                await _search(value.trim());
              },
            ),
          ),
        );
      },
    );
  }
}