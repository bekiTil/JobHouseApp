import '../data_Providers/data_providers.dart';
import '../models/models.dart';

class PostRepository {
  final PostDataProvider postDataProvider;

  PostRepository(this.postDataProvider);

  Future<Post> create(Post post) async {
    try {
      return postDataProvider.create(post);
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> update(int id, Post post) async {
    return postDataProvider.update(id, post);
  }

  Future<List<Post>> fetchAll() async {
    return postDataProvider.fetchAll();
  }

  Future<List<Post>> fetchAllByUserID() async {
    try {
      return await postDataProvider.fetchAllByUserId();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(int id) async {
    postDataProvider.delete(id);
  }
}
