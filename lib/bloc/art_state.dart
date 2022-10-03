part of 'art_bloc.dart';

enum ArtStatus { initial, success, error, loading }

extension AllGamesStatusX on ArtStatus {
  bool get isInitial => this == ArtStatus.initial;
  bool get isSuccess => this == ArtStatus.success;
  bool get isError => this == ArtStatus.error;
  bool get isLoading => this == ArtStatus.loading;
}

class AllArtState extends Equatable {
  AllArtState({
    this.status = ArtStatus.initial,
    List<ArtListItem>? artObjects,
    ArtDetail? artDetailObject,
    this.isFirstFetch = false,
  })  : artObjects = artObjects ?? [],
        artDetailsObject = artDetailObject ?? const ArtDetail();

  final List<ArtListItem> artObjects;
  final ArtDetail artDetailsObject;
  final ArtStatus status;
  final bool isFirstFetch;

  @override
  List<Object?> get props => [status, artObjects];

  AllArtState copyWith({
    List<ArtListItem>? artObjects,
    ArtStatus? status,
    bool? isFirstFetch,
  }) {
    return AllArtState(
      artObjects: artObjects ?? this.artObjects,
      status: status ?? this.status,
      isFirstFetch: isFirstFetch ?? this.isFirstFetch,
    );
  }

  AllArtState copyArtDetailObjectWith({
    ArtDetail? artDetailObject,
    ArtStatus? status,
    bool? isFirstFetch,
  }) {
    return AllArtState(
      artDetailObject: artDetailObject ?? artDetailsObject,
      status: status ?? this.status,
      isFirstFetch: isFirstFetch ?? this.isFirstFetch,
    );
  }
}
