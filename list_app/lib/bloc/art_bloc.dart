import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_app/data/repositories/models/art_detail_model.dart';
import 'package:list_app/data/repositories/models/art_list_item_model.dart';
import 'package:list_app/data/repositories/posts_repository.dart';

part 'art_event.dart';
part 'art_state.dart';

class ArtBloc extends Bloc<ArtEvent, AllArtState> {
  ArtBloc({
    required this.artObjectsRepository,
  }) : super(AllArtState()) {
    on<GetArtObjectsForList>(_mapGetArtListObjectsEventToState);
    on<GetArtDetails>(_mapGetArtDetailsEventToState);
  }

  final ArtRepository artObjectsRepository;
  int page = 1;
  List<ArtListItem> oldPosts = [];

  // this bloc receives a page parameter
  // and updates the state with the correct list items
  void _mapGetArtListObjectsEventToState(
      GetArtObjectsForList event, Emitter<AllArtState> emit) async {
    try {
      // Bloc has been added and will now be set in the loading state
      // If this is first time loading listview page show loading indicator in page
      emit(
        state.copyWith(
          status: ArtStatus.loading,
          isFirstFetch: page <= 1,
        ),
      );
      // call the repo to retrieve the list data
      await artObjectsRepository.getArtObjectsList(page).then((newPosts) {
        page++;
        oldPosts.addAll(newPosts);
        // set bloc state to success cause data was retrieved
        emit(state.copyWith(
          artObjects: oldPosts,
          status: ArtStatus.success,
          isFirstFetch: page <= 1,
        ));
      });
    } catch (error) {
      // something went wrong in the try catch
      // set status to error
      emit(state.copyWith(status: ArtStatus.error));
    }
  }

  // Get the detail data from the repo with postId
  void _mapGetArtDetailsEventToState(
      GetArtDetails event, Emitter<AllArtState> emit) async {
    try {
      // Set state to Loading
      emit(
        state.copyArtDetailObjectWith(
          status: ArtStatus.loading,
        ),
      );
      // Fetch ArtObject details data from Repo
      final receivedArtDetailObject =
          await artObjectsRepository.getArtObjectDetails(event.postId);
      // Set State to succes if details object has been returned
      emit(
        state.copyArtDetailObjectWith(
          artDetailObject: receivedArtDetailObject,
          status: ArtStatus.success,
        ),
      );
    } catch (error) {
      // Something went wrong in the try catch
      // Set status to error
      emit(
        state.copyArtDetailObjectWith(
          status: ArtStatus.error,
        ),
      );
    }
  }
}
