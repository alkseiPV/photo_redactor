import 'package:hive/hive.dart';
import 'package:photo_redactor/domain/models/work_model.dart';

class HiveDataBase {
  Box<WorkModel>? box;
  List<WorkModel> works = [];

  initBox() async {
    box = Hive.box<WorkModel>('myWorks');
  }

  addWorkInDB(WorkModel work) {
    for (var element in box!.values) {
      if (element.endedFileName.contains(work.endedFileName)) {
        box!.delete(element.key);
        break;
      }
    }
    box!.add(work);
  }

  getAllworks() {
    works = [];

    for (var element in box!.values) {
      works.add(element);
    }

    return works;
  }

  deleteWork(int index) async {
    await box!.deleteAt(index);

    return true;
  }
}
