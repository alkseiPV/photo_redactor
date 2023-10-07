import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_redactor/domain/Bloc/work_event.dart';
import 'package:photo_redactor/domain/Bloc/work_state.dart';
import 'package:photo_redactor/domain/models/work_model.dart';
import 'package:photo_redactor/domain/usecases/my_works_usecase.dart';

class WorkBloc extends Bloc<WorkEvent, WorkState> {
  MyWorksUseCase myWorksUseCase;
  WorkBloc({required this.myWorksUseCase}) : super(EmptyWorkState()) {
    on<AddWorkEvent>((event, emit) {
      myWorksUseCase.addWork(event.workModel);
    });

    on<GetAllWorksEvent>((event, emit) async {
      emit(LoadingWorkState());

      List<WorkModel> works = await myWorksUseCase.getAllWorks();

      emit(LoadedWorkState(works: works));
    });

    on<DeleteWorkEvent>((event, emit) {
      myWorksUseCase.deleteWork(event.index);
      add(GetAllWorksEvent());
    });
  }
}
