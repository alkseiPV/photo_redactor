import 'package:photo_redactor/domain/models/work_model.dart';

abstract class WorkState {}

class EmptyWorkState extends WorkState {}

class LoadingWorkState extends WorkState {}

class LoadedWorkState extends WorkState {
  List<WorkModel> works;
  LoadedWorkState({required this.works});
}

class ErrorWorkState extends WorkState {}
