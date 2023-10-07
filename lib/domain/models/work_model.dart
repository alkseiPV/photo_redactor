// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'work_model.g.dart';

@HiveType(typeId: 0)
class WorkModel extends Equatable with HiveObjectMixin {
  @HiveField(0)
  final String endedFileName;
  @HiveField(1)
  final String startedFileName;
  @HiveField(2)
  final List<int> actions;

  WorkModel(
      {required this.actions,
      required this.endedFileName,
      required this.startedFileName});
  @override
  List<Object?> get props => [endedFileName, startedFileName, actions];
}
