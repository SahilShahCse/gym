import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym/widgets/custom_list_tile.dart';

class CustomList extends StatefulWidget {

  final List title;
  final List subtitle;
  final List? onTap;

  const CustomList(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  State<CustomList> createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (widget.title.length / 2).ceil(), // Calculate the number of rows
      itemBuilder: (BuildContext context, int index) {

        final int firstIndex = index * 2;
        final int secondIndex = firstIndex + 1;

        return Row(
          children: [
            Expanded(
              child: CustomListTile(
                title: widget.title[firstIndex],
                subtitle: widget.subtitle[firstIndex],
              ),
            ),
            if (secondIndex < widget.title.length) // Ensure second tile exists
              SizedBox(width: 16),
            if (secondIndex < widget.title.length) // Ensure second tile exists
              Expanded(
                child: CustomListTile(
                  title: widget.title[secondIndex],
                  subtitle: widget.subtitle[secondIndex],
                ),
              ),
          ],
        );
      },
    );
  }
}
