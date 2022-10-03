// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_list_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtListItem _$ArtListItemFromJson(Map<String, dynamic> json) => ArtListItem(
      title: json['title'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ArtListItemToJson(ArtListItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'image': instance.image,
      'description': instance.description,
    };
