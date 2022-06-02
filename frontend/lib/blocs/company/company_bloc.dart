import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/company_data_provider.dart';
import 'package:frontend/data_Providers/data_providers.dart';
import 'package:frontend/models/Company.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/repository.dart';
import 'package:meta/meta.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super( CompanyInitial()) {
    on<CompanyHomeVisited>((event, emit) async {
      emit( CompanyHomeLoading());

      try {
        StorageService storage = StorageService();
        String? id = await storage.getId();
        Company user = await CompanyDataProvider.fetchSingle(id!);

        PostDataProvider provider = PostDataProvider();
        List<Post> posts = await provider.fetchAll();
        await Future.delayed(const Duration(seconds: 2));
        
        emit(CompanyHomeLoaded(
            username: user.username,
            email: user.email,
            fullName: user.fullName,
            location: user.companyProfile.location,
            bio: user.companyProfile.bio,
            posts: posts));
      } catch (e) {
        emit(CompanyHomeLoadingFailed(exception: e.toString()));
      }
    });
  }
}
