import 'package:photo_redactor/data/datasource/hive_bd.dart';
import 'package:photo_redactor/domain/models/work_model.dart';
import 'package:photo_redactor/domain/repositories/works_repository.dart';

class WorkRepositoryIMPL implements WorksRepository {
  HiveDataBase hiveDataBase;
  WorkRepositoryIMPL({required this.hiveDataBase});
  @override
  Future<bool> addWork(WorkModel work) async {
    await hiveDataBase.addWorkInDB(work);

    return true;
  }

  @override
  Future<List<WorkModel>> getAllWorks() async {
    return await hiveDataBase.getAllworks();
  }

  @override
  Future<bool> deleteWork(int index) async {
    return await hiveDataBase.deleteWork(index);
  }
}
