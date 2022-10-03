import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:list_app/bloc/art_bloc.dart';
import 'package:list_app/data/repositories/models/art_list_item_model.dart';
import 'package:list_app/presentation/widgets/art_list_item.dart';

class ArtListWidget extends StatefulWidget {
  const ArtListWidget({
    Key? key,
    required this.artListObjects,
    required this.title,
  }) : super(key: key);
  final List<ArtListItem> artListObjects;
  final String title;

  @override
  State<ArtListWidget> createState() => _ArtListWidgetState();
}

class _ArtListWidgetState extends State<ArtListWidget> {
  @override
  void initState() {
    _controller.addListener(_onScrollEvent);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(_onScrollEvent);
    super.dispose();
  }

  void _onScrollEvent() {
    if (_controller.position.atEdge && _controller.position.pixels != 0) {
      // trigger bloc to fetch for new list items
      context.read<ArtBloc>().add(
            GetArtObjectsForList(),
          );
    }
  }

  // scroll controller for the listview
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, top: 24),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          child: GroupedListView<ArtListItem, String>(
            controller: _controller,
            elements: widget.artListObjects,
            useStickyGroupSeparators: true,
            itemComparator: ((artItem1, artItem2) =>
                artItem1.title!.compareTo(artItem2.title!)),
            groupBy: (artItem) => artItem.maker ?? '',
            groupSeparatorBuilder: (artItemMaker) => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey,
              child: Text(artItemMaker),
            ),
            itemBuilder: (context, artItem) => AllArtListItem(
              artObjects: artItem,
            ),
          ),
        ),
      ],
    );
  }
}
