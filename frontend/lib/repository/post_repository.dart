import '../data_Providers/data_providers.dart';
import '../models/models.dart';

class PostRepository {
  final PostDataProvider postDataProvider;

  PostRepository(this.postDataProvider);

  Future<Post> create(Post post) async {
    return postDataProvider.create(post);
  }

  Future<Post> update(int id, Post post) async {
    return postDataProvider.update(id, post);
  }

  Future<List<Post>> fetchAll() async {
    return postDataProvider.fetchAll();
  }

  Future<void> delete(int id) async {
    postDataProvider.delete(id);
  }
}
