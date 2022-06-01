import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/employee_data_provider.dart';
import 'package:meta/meta.dart';

part 'editEmployee_event.dart';
part 'editEmployee_state.dart';

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  EditEmployeeBloc() : super(EditEmployeeInitial()) {
    on<EditEmployee>((event, emit) async {
      emit(EditingProfile());
      try {
        await EmployeeDataProvider.edit(
          event.fieldOfStudy,
          event.educationLevel,
          event.yearsOfExperience,
          event.location,
          event.bio,
          event.token,
          event.id,
        );
        emit(EditProfileSuccess());
      } catch (e) {
        emit(EditProfileFailed(e.toString()));
      }
    });
  }
}
