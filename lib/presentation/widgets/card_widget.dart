// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_redactor/domain/Bloc/work_bloc.dart';
import 'package:photo_redactor/domain/Bloc/work_event.dart';
import 'package:photo_redactor/domain/models/work_model.dart';
import 'package:photo_redactor/presentation/pages/holst_page.dart';
import 'package:photo_redactor/presentation/providers/holst_page_provider.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.workModel, required this.index});
  final WorkModel workModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        height: 100.h,
        child: InkWell(
          onTap: () async {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HolstPage(),
                ),
                (route) => false);
            await context
                .read<HolstPageProvider>()
                .imageValueNotifier
                .loadImage(File(workModel.startedFileName));
            context.read<HolstPageProvider>().steps =
                List.from(workModel.actions);
            context.read<HolstPageProvider>().initialImage =
                File(workModel.startedFileName);
            context.read<HolstPageProvider>().selectAsset(true);

            context.read<HolstPageProvider>().deleteSteps(0);
          },
          child: Row(children: [
            Image.file(File(workModel.endedFileName)),
            const SizedBox(
              width: 20,
            ),
            Text(workModel.endedFileName.split('/').last),
            const Spacer(),
            IconButton(
                onPressed: () {
                  context.read<WorkBloc>().add(DeleteWorkEvent(index: index));
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
          ]),
        ),
      ),
    );
  }
}
