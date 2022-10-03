import 'package:json_annotation/json_annotation.dart';

part 'art_detail_model.g.dart';

@JsonSerializable()
class ArtDetail {
  const ArtDetail({
    this.title,
    this.id,
    this.image,
    this.description,
    this.type,
    this.labelDesc,
  });
  final String? title;
  final String? id;
  final String? image;
  final String? description;
  final String? type;
  final String? labelDesc;

  static const empty = ArtDetail(
    title: '',
    id: '',
    image: '',
    description: '',
    type: '',
    labelDesc: '',
  );

  factory ArtDetail.fromJsons(Map<String, dynamic> json) {
    return ArtDetail(
      title: json["title"],
      image: json["webImage"]["url"],
      description: json["description"],
      id: json["objectNumber"],
      type: json["objectTypes"][0],
      labelDesc: json["principalMakers"][0]["labelDesc"],
    );
  }
}
