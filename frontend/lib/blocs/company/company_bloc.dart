import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/company_data_provider.dart';
import 'package:frontend/models/Company.dart';
import 'package:meta/meta.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(const CompanyInitial()) {
    on<CompanyHomeVisited>((event, emit) async {
      emit(const CompanyHomeLoading());

      try {
        Company user = await CompanyDataProvider.fetchSingle(event.id);
        print('asd');
        await Future.delayed(const Duration(seconds: 2));
        
        emit(CompanyHomeLoaded(
            username: user.username,
            email: user.email,
            fullName: user.fullName,
            location: user.companyProfile.location,
            bio: user.companyProfile.bio));
      } catch (e) {
        emit(CompanyHomeLoadingFailed(exception: e.toString()));
      }
    });
  }
}
