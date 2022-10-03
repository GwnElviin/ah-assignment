import 'package:list_app/data/repositories/models/art_detail_model.dart';
import 'package:list_app/data/repositories/models/art_list_item_model.dart';
import 'package:list_app/data/repositories/services/art_service.dart';

class ArtRepository {
  const ArtRepository({
    required this.service,
  });
  final ArtService service;

  Future<List<ArtListItem>> getArtObjectsList(int page) async =>
      service.getArtObjectList(page);

  Future<ArtDetail> getArtObjectDetails(String postId) async =>
      service.getArtDetails(postId);
}
