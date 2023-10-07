import 'package:get_it/get_it.dart';
import 'package:photo_redactor/data/datasource/hive_bd.dart';
import 'package:photo_redactor/data/repositories/work_repository_impl.dart';
import 'package:photo_redactor/domain/Bloc/work_bloc.dart';
import 'package:photo_redactor/domain/repositories/works_repository.dart';
import 'package:photo_redactor/domain/usecases/my_works_usecase.dart';

GetIt locator = GetIt.I;

setupLocator() async {
  locator.registerFactory(() => WorkBloc(myWorksUseCase: locator()));
  locator.registerLazySingleton(() => HiveDataBase()..initBox());
  locator.registerLazySingleton<WorksRepository>(
    () => WorkRepositoryIMPL(hiveDataBase: locator()),
  );
  locator.registerLazySingleton(() => MyWorksUseCase(locator()));
}
