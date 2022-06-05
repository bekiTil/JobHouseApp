import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/blocs/blocs.dart';
import 'package:frontend/blocs/post/bloc/post_bloc.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

final Post company = Post(
  id: '1',
  poster_id: '1',
  number: 1,
  description: 'description',
  category: 'TECK',
  posterName: 'posterName',
  image: 'asdf',
  date: 'date',
);

class MockPostRepository extends Mock implements PostRepository {}

@GenerateMocks([CompanyRepository, PostRepository])
void main() {
  final mockPostRepository = MockPostRepository();
  group('Post Bloc', () {
    blocTest<PostBloc, PostState>(
      'emits nothing when no event is added',
      build: () => PostBloc(),
      expect: () => [],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostOperationLoading, PostOperationFailed] when PostCreate is added',
      build: () => PostBloc(),
      act: (postBloc) => postBloc.add(PostCreate("asdf", 1, "TECK")),
      expect: () => [
        PostOperationLoading(),
        PostOperationFailed("fake exception"),
      ],
    );

    blocTest<PostBloc, PostState>(
      'emits [PostOperationLoading, PostOperationFailed] when DeletePost is added',
      build: () => PostBloc(),
      act: (postBloc) => postBloc.add(DeletePost("fakeUser")),
      expect: () => [
        PostOperationLoading(),
        PostOperationFailed("fake exception"),
      ],
    );
  });
}
