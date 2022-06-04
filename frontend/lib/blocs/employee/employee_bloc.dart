import 'package:bloc/bloc.dart';
import 'package:frontend/data_Providers/data_providers.dart';

import 'package:frontend/repository/employee_repository.dart';
import 'package:frontend/repository/post_repository.dart';
import 'package:meta/meta.dart';
import 'package:frontend/models/Employee.dart';

import '../../models/post.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<EmployeeHomeVisited>((event, emit) async {
      emit(EmployeeHomeLoading());

      try {
        EmployeeRepository employeeRepository = EmployeeRepository();
        Employee user = await employeeRepository.fetchSingle();
        
        PostRepository postRepository = PostRepository(PostDataProvider());
        List<Post> posts = await postRepository.fetchAll();
        

        emit(EmployeeHomeLoaded(
            id: user.id,
            username: user.username,
            email: user.email,
            fullName: user.fullName,
            location: user.employeeProfile.location,
            bio: user.employeeProfile.bio,
            posts: posts));
      } catch (e) {
        emit(EmployeeHomeLoadingFailed(exception: e.toString()));
      }
    });

    on<DeleteEmployee>((event, emit) async {
      emit(EmployeeDeleting());

      try {
        await Future.delayed(Duration(seconds: 2));
        EmployeeRepository employeeRepository = EmployeeRepository();
        await employeeRepository.deleteSingle();
        emit(EmployeeDeletionSuccess());
      } catch (e) {
        emit(EmployeeDeletionFailed(e.toString()));
      }
    });
  }
}
