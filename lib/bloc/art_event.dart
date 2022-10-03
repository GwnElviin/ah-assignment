part of 'art_bloc.dart';

class ArtEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetArtObjectsForList extends ArtEvent {}

class GetArtDetails extends ArtEvent {
  final String postId;

  GetArtDetails({required this.postId});
}
