import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/data_providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial(Post(number: 0, description: ' ', category: ' '))) {
    on<PostCreate>((event, emit) async {
      emit(PostCreating(Post(number: 0, description: ' ', category: ' ')));
      try {
        Post createdPost = Post(
          number: event.number,
          description: event.description,
          category: event.category,
        );

        PostRepository repo = PostRepository(PostDataProvider());
        Post post = await repo.create(createdPost);
        emit(PostCreated(post));
      } catch (e) {
        emit(PostCreationFailed(e.toString(), Post(number: 0, description: ' ', category: ' ')));
      }
    });
  }
}
