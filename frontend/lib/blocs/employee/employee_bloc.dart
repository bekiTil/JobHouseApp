import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/employee_data_provider.dart';
import 'package:frontend/models/Employee.dart';
import 'package:meta/meta.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeInitial()) {
    on<EmployeeHomeVisited>((event, emit) async {
      emit(const EmployeeHomeLoading());
        print('object');

      try {
        Employee user = await EmployeeDataProvider.fetchSingle();
        await Future.delayed(const Duration(seconds: 2));
        
        emit(EmployeeHomeLoaded(
            username: user.username,
            email: user.email,
            fullName: user.fullName,
            location: user.employeeProfile.location,
            bio: user.employeeProfile.bio));
      } catch (e) {
        emit(EmployeeHomeLoadingFailed(exception: e.toString()));
      }
    });
  }
}
