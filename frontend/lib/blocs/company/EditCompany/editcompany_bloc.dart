import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/company_data_provider.dart';
import 'package:frontend/models/company_profile.dart';
import 'package:meta/meta.dart';

part 'editcompany_event.dart';
part 'editcompany_state.dart';

class EditCompanyBloc extends Bloc<EditcompanyEvent, EditCompanyState> {
  EditCompanyBloc() : super(EditcompanyInitial()) {
    on<EditCompany>((event, emit) async{
      emit(EditingProfile());
      try {
        await CompanyDataProvider.edit(event.location, event.bio, event.token, event.id);
        emit(EditProfileSuccess());
      } catch (e) {
        emit(EditProfileFailed(e.toString()));
      }
    });
  }
}
