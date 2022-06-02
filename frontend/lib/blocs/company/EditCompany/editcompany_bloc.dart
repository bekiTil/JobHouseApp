import 'package:bloc/bloc.dart';
import 'package:frontend/repository/company_repository.dart';
import 'package:meta/meta.dart';

part 'editcompany_event.dart';
part 'editcompany_state.dart';

class EditCompanyBloc extends Bloc<EditcompanyEvent, EditCompanyState> {
  EditCompanyBloc() : super(EditcompanyInitial()) {
    on<EditCompany>((event, emit) async {
      emit(EditingProfile());
      try {
        CompanyRepository companyRepository = CompanyRepository();
        await companyRepository.edit(
            event.location, event.bio, event.token, event.id);
        emit(EditProfileSuccess());
      } catch (e) {
        emit(EditProfileFailed(e.toString()));
      }
    });
  }
}
