import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:list_app/data/repositories/models/art_detail_model.dart';
import 'package:list_app/data/repositories/models/art_list_item_model.dart';
import 'package:list_app/data/repositories/models/result_error.dart';

class ArtService {
  ArtService({
    http.Client? httpClient,
    this.baseUrl = 'https://www.rijksmuseum.nl/api/nl/collection',
    this.privateKey = '0fiuZFh4',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  // Private key be stored in enviroment keys
  final String privateKey;
  final Client _httpClient;
  static const fetchLimit = 15;

  // Retrieve a list of art objects from api
  Future<List<ArtListItem>> getArtObjectList(int page) async {
    final response = await _httpClient.get(Uri.parse(
        "$baseUrl?s=artist&key=$privateKey&ps=$fetchLimit&p=$page&imgonly=true"));

    // if data is retrieved correctly and not empty
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final artObjectsJson = jsonDecode(response.body)['artObjects'];

        return List<ArtListItem>.from(
          artObjectsJson.map(
            (data) => ArtListItem.fromJsons(data),
          ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingArt('Error getting Art.');
    }
  }

  Future<ArtDetail> getArtDetails(String postId) async {
    String detailUri = "/$postId?key=$privateKey";

    final response = await _httpClient.get(Uri.parse('$baseUrl$detailUri'));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final artObjectJson = jsonDecode(response.body)['artObject'];
        return ArtDetail.fromJsons(artObjectJson);
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingArt('Error getting Art.');
    }
  }
}
