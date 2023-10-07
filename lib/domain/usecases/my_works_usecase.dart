import 'package:photo_redactor/domain/models/work_model.dart';
import 'package:photo_redactor/domain/repositories/works_repository.dart';

class MyWorksUseCase {
  final WorksRepository worksRepository;
  MyWorksUseCase(this.worksRepository);

  Future<List<WorkModel>> getAllWorks() async {
    return await worksRepository.getAllWorks();
  }

  Future<bool> addWork(WorkModel workModel) async {
    return await worksRepository.addWork(workModel);
  }

  Future<bool> deleteWork(int index) async {
    return await worksRepository.deleteWork(index);
  }
}
