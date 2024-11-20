import '../../../image/ui/widgets/show_rect_image.dart';
import '../providers/institute_page_read_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/institute_public.dart';

class SearchInstitute extends StatefulWidget {
  final Function(InstitutePub institute) onSelect;
  final String hintText;
  final String labelText;
  const SearchInstitute({super.key, required this.onSelect, required this.hintText, required this.labelText});

  @override
  State<SearchInstitute> createState() => _SearchInstituteState();
}

class _SearchInstituteState extends State<SearchInstitute> {

  final FocusNode _focusNode = FocusNode(); 
  final TextEditingController _searchInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<InstitutePub> searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    context.read<InstitutePageReadProvider>().searchClear();
    context.read<InstitutePageReadProvider>().searchByName("");
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
    // _scrollController.addListener((){
    //   _scrollController.position.
    // });
  }

  Future<void> _search(String text) async{
    await context.read<InstitutePageReadProvider>().searchByName(text);
  }

  @override
  Widget build(BuildContext context) {
    final institutes = context.watch<InstitutePageReadProvider>().searchedInstituteList;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(widget.labelText, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.context(context).textGreyColor),)
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _searchInput(),
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: institutes.length,
                      itemBuilder: (context, index) {
                        final institute = institutes[index];
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
                                  widget.onSelect(institute);
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ShowRectImage(imageUrl: institute.logoUrl, borderRadiusVal: 4, height: 40, width: 40,),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: FittedBox(
                                          child: Text(institute.pageName, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium,)
                                        ),
                                      ),
                                    )
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
                    )
                  ],
                ),
              ),

              
            ],
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