import 'package:flutter/material.dart';

import 'custom_list_tile_item_widget.dart';

class MyCustomListView extends StatefulWidget {
  final List<CustomListTileModel> initialData;
  final Future<List<CustomListTileModel>> Function()? loadMoreData;
  final Function(String)? onItemTap;
  const MyCustomListView({
    super.key,
    required this.initialData,
    this.loadMoreData,
    this.onItemTap,
  });

  @override
  State<MyCustomListView> createState() => _MyCustomListViewState();
}

class _MyCustomListViewState extends State<MyCustomListView> {
  ScrollController scrollController = ScrollController();
  late List<CustomListTileModel> data;
  var loadingMoreData = false;

  @override
  void initState() {
    super.initState();
    data = widget.initialData;
    if (widget.loadMoreData != null) {
      scrollController.addListener(_scrollListener);
    } else {
      print('widget.loadMoreData => ${widget.loadMoreData}');
    }
  }

  _scrollListener() {
    scrollController.addListener(() async {
      var nextPageTrigger =
          0.8 * scrollController.position.maxScrollExtent - 10;
      var position = scrollController.position.pixels;
      if (position > nextPageTrigger) {
        if (!loadingMoreData) {
          setState(() {
            loadingMoreData = true;
          });
          List<CustomListTileModel> result = await widget.loadMoreData!();
          print('retorna => ${result.length}');

          setState(() {
            data.addAll(result);
            loadingMoreData = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build CustomListView.data.length => ${data.length}');
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            controller: scrollController,
            primary: false,
            shrinkWrap: true,
            itemCount: data.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (_, i) {
              return CustomListTileItem(
                item: data[i],
                onItemTap: widget.onItemTap,
              );
            },
          ),
        ),
        Visibility(
          visible: loadingMoreData,
          child: Container(
            color: Colors.white,
            width: size.width * 0.9,
            height: size.width * 0.2,
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue), // Color del indicador
              strokeWidth: size.width * 0.05, // Ancho del indicador
            ),
          ),
        )
      ],
    );
  }
}