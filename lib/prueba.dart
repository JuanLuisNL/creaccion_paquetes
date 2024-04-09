import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mi_paquete/widget/custom_list_tile_item_widget.dart';
import 'package:mi_paquete/widget/custom_list_view_widget.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CustomListTileModel> listViewData = [];

  Future<List<CustomListTileModel>> getMoreData() async {
    await Future.delayed(const Duration(seconds: 2));
    var intValue = Random().nextInt(10);
    List<CustomListTileModel> newList = List<CustomListTileModel>.generate(
      10,
          (index) => CustomListTileModel(
        id: (index * intValue).toString(),
        title: 'Title ${index + listViewData.length}',
        status: 'Status ${index + listViewData.length}',
        subTitle: 'Subtitle ${index + listViewData.length}',
        image: const Icon(Icons.abc),
      ),
    );
    return newList;
  }

  setInitialData() async {
    List<CustomListTileModel> initialData = await getMoreData();
    setState(() {
      print('listViewData.length => ${listViewData.length}');
      listViewData.addAll(initialData);
      print('listViewData.length => ${listViewData.length}');
    });
  }

  @override
  void initState() {
    super.initState();
    setInitialData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('build');
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: Container(
            width: size.width * 0.9,
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              children: [
                const Text('You can put your seach box here y you want'),
                Expanded(
                  child: MyCustomListView(
                    initialData: listViewData,
                    loadMoreData: getMoreData,
                    onItemTap: (String id) {
                      print('detail/$id');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}