import 'package:dormsity/core/utils/routing/smooth_page_transition.dart';

import 'core/utils/func/dekhao.dart';
import 'features/image/ui/widgets/show_rect_image.dart';
import 'features/page_entity/domain/entities/institute_public.dart';
import 'package:provider/provider.dart';

import 'core/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'view_page.dart';
import 'features/page_entity/ui/providers/institute_page_read_provider.dart';


class SearchPage extends StatefulWidget {

  const SearchPage({super.key,});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final FocusNode _focusNode = FocusNode(); 
  final TextEditingController _searchInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<InstitutePub> searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
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
    final pages = context.watch<InstitutePageReadProvider>().searchedInstituteList;
    dekhao("Pages found after search is ${pages.length}");
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          backgroundColor: AppColors.context(context).contentBoxColor,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: _searchInput(),
          ),
          body: SingleChildScrollView(
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
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          color: AppColors.context(context).dividerColor,
                          width: constraints.maxWidth,
                          height: index == 0 ? 1 : 0,
                        ),
          
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, SmoothPageTransition().rightToLeft(secondScreen: ViewPage(page: page,)));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ShowRectImage(imageUrl: page.logoUrl, borderRadiusVal: 4, height: 40, width: 40,),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(page.pageName, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium,),
                                    ),
                                  )
                                ],
                              ),
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
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                hintText: 'Type page name...',
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