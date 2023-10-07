import 'package:photo_redactor/domain/models/work_model.dart';

abstract class WorkEvent {}

class AddWorkEvent extends WorkEvent {
  WorkModel workModel;
  AddWorkEvent({required this.workModel});
}

class GetAllWorksEvent extends WorkEvent {}

class DeleteWorkEvent extends WorkEvent {
  int index;
  DeleteWorkEvent({required this.index});
}
