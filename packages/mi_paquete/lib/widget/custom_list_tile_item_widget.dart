import 'package:flutter/material.dart';

class CustomListTileModel {
  final String id;
  final String title;
  final String status;
  final String subTitle;
  final Widget image;

  const CustomListTileModel({
    required this.id,
    required this.title,
    required this.status,
    required this.subTitle,
    required this.image,
  });
}

class CustomListTileItem extends StatelessWidget {
  final CustomListTileModel item;
  final Function(String)? onItemTap;

  const CustomListTileItem({
    super.key,
    required this.item,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.yellow,
        child: item.image,
      ),
      title: Text(item.title),
      subtitle: Text(item.subTitle),
      trailing: const Icon(Icons.check),
      onTap: () {
        if (onItemTap != null) {
          onItemTap!(item.id);
        }
      },
    );
  }
}