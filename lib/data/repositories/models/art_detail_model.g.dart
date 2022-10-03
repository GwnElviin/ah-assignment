// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtDetail _$ArtDetailFromJson(Map<String, dynamic> json) => ArtDetail(
      title: json['title'] as String?,
      id: json['id'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      labelDesc: json['labelDesc'] as String?,
    );

Map<String, dynamic> _$ArtDetailToJson(ArtDetail instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'image': instance.image,
      'description': instance.description,
      'type': instance.type,
      'labelDesc': instance.labelDesc,
    };
