import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/data_providers.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/repository/repository.dart';
import 'package:meta/meta.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitial()) {
    on<CompanyHomeVisited>((event, emit) async {
      emit(CompanyHomeLoading());
      try {
        CompanyRepository companyRepository = CompanyRepository();
        Company user = await companyRepository.fetchSingle();
        PostRepository postRepository = PostRepository(PostDataProvider());
        List<Post> posts = await postRepository.fetchAllByUserID();
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
    on<DeleteCompany>(((event, emit) async {
      emit(DeletingCompanuProfile());

      try {
        CompanyRepository companyRepository = CompanyRepository();

        await companyRepository.deleteSingle(event.userName);
        emit(CompanyProfileDeletionSuccessfull());
      } catch (e) {
        emit(CompanyProfileDeletionFailed());
      }
    }));
  }
}
