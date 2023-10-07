import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_redactor/domain/Bloc/work_bloc.dart';
import 'package:photo_redactor/locator.dart';

import 'package:provider/provider.dart';

import 'presentation/providers/holst_page_provider.dart';

class MuiltiProvidersWidget extends StatelessWidget {
  const MuiltiProvidersWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<WorkBloc>(
          create: (context) => locator<WorkBloc>(),
        ),
        ChangeNotifierProvider<HolstPageProvider>(
          create: (context) => HolstPageProvider(),
        ),
      ],
      child: child,
    );
  }
}
