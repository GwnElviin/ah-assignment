import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:list_app/data/repositories/models/art_list_item_model.dart';
import 'package:list_app/presentation/pages/art_detail_page.dart';

class AllArtListItem extends StatelessWidget {
  const AllArtListItem({
    Key? key,
    required this.artObjects,
  }) : super(key: key);

  final ArtListItem artObjects;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            width: 100,
            height: 100,
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  "${artObjects.image}", //http://via.placeholder.com/350x150
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fadeOutDuration: const Duration(seconds: 1),
              fadeInDuration: const Duration(seconds: 2),
            ),
          ),
          // SizedBox(
          //     width: 100,
          //     height: 100,
          // child: CachedNetworkImage(
          //   imageUrl:
          //       "${artObjects.image}", //http://via.placeholder.com/350x150
          //   placeholder: (context, url) => const CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => const Icon(Icons.error),
          //   fadeOutDuration: const Duration(seconds: 1),
          //   fadeInDuration: const Duration(seconds: 3),
          // )
          //     // Image.network(
          //     //   fit: BoxFit.cover,
          //     //   '${artObjects.image}',
          //     // ),
          //     ),
          title: Text(
            artObjects.title ?? '',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text('#${artObjects.maker}'),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          isThreeLine: true,
          onTap: () {
            bottomSheetModal(context);
          },
        ),
      ),
    );
  }

  Future<void> bottomSheetModal(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height - 175,
          color: const Color.fromRGBO(58, 66, 86, 1.0),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 24, bottom: 8, left: 8, right: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.topLeft,
                    height: 50,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.chevron_left,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    )),
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.black,
                  child:
                      Image.network(fit: BoxFit.cover, '${artObjects.image}'),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  '${artObjects.title}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  overflow: TextOverflow.ellipsis,
                  "${artObjects.longTitle}",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    child: const Text('See More'),
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeDetailPage(
                              postId: artObjects.id,
                            ),
                          ),
                        )),
              ],
            ),
          ),
        );
      },
    );
  }
}
