import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/data_providers.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostCreate>((event, emit) async {
      emit(PostOperationLoading());
      try {
        Map<String, dynamic> createdPost = {
          "number": event.number,
          "description": event.description,
          "category": event.category,
        };

        PostRepository repo = PostRepository(PostDataProvider());
        await repo.create(createdPost);
        emit(PostOperationSuccess());
      } catch (e) {
        emit(PostOperationFailed(e.toString()));
      }
    });

    on<DeletePost>((event, emit) async {
      emit(PostOperationLoading());

      try {
        PostRepository postRepository = PostRepository(PostDataProvider());
        await postRepository.delete(event.id);
        emit(PostOperationSuccess());
      } catch (e) {
        emit(PostOperationFailed(e.toString()));
      }
    });

    on<EditPost>((event, emit) async {
      emit(PostEditingOperationStarted(event.post));
      try {
        await Future.delayed(const Duration(seconds: 3));
        emit(PostOperationSuccess());
      } catch (e) {
        emit(PostOperationFailed(e.toString()));
      }
    });
  }
}
