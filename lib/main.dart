import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:photo_redactor/domain/models/work_model.dart';
import 'package:photo_redactor/locator.dart';
import 'package:photo_redactor/multi_providers.dart';
import 'package:photo_redactor/presentation/pages/holst_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(WorkModelAdapter());
  await Hive.openBox<WorkModel>('myWorks');
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
        designSize: Size(1080, 1920),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MuiltiProvidersWidget(child: MaterialApp(home: HolstPage())));
  }
}
