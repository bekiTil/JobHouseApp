import '../data_Providers/data_providers.dart';
import '../models/models.dart';

class PostRepository {
  final PostDataProvider postDataProvider;

  PostRepository(this.postDataProvider);

  Future<Post> create(Map post) async {
    try {
      return postDataProvider.create(post);
    } catch (e) {
      rethrow;
    }
  }

  Future<Post> update(String id, Post post) async {
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

  Future<Post> fetchById(String id) async {
    try {
      return await postDataProvider.fetchById(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await postDataProvider.delete(id);
    } catch (e) {
      rethrow;
    }
  }
}
