import 'package:photo_redactor/domain/models/work_model.dart';

abstract class WorksRepository {
  Future<List<WorkModel>> getAllWorks();
  Future<bool> addWork(WorkModel work);
  Future<bool> deleteWork(int index);
}
