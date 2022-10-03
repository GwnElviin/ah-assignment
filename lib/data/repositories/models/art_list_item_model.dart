import 'package:json_annotation/json_annotation.dart';

part 'art_list_item_model.g.dart';

@JsonSerializable()
class ArtListItem {
  const ArtListItem({
    this.title,
    this.id,
    this.image,
    this.description,
    this.maker,
    this.longTitle,
  });
  final String? title;
  final String? id;
  final String? image;
  final String? description;
  final String? maker;
  final String? longTitle;

  static const empty = ArtListItem(
    title: '',
    id: '',
    image: '',
    description: '',
    maker: '',
    longTitle: '',
  );

  factory ArtListItem.fromJsons(Map<String, dynamic> json) {
    return ArtListItem(
      title: json["title"] ?? '',
      image: json["webImage"]["url"] ?? '',
      description: json["description"] ?? '',
      id: json["objectNumber"] ?? '',
      maker: json["principalOrFirstMaker"] ?? '',
      longTitle: json["longTitle"],
    );
  }
}
