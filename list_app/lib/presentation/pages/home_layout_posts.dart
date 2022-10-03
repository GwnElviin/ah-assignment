import 'package:flutter/material.dart';
import 'package:list_app/presentation/widgets/body_art_list_widget.dart';
import 'package:list_app/presentation/widgets/container_art_list.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        ContainerArtList(
          children: [
            BodyArtListWidget(title: 'All posts'),
          ],
        )
      ],
    );
  }
}
