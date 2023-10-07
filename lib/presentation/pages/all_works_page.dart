import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_redactor/domain/Bloc/work_bloc.dart';
import 'package:photo_redactor/domain/Bloc/work_event.dart';
import 'package:photo_redactor/domain/Bloc/work_state.dart';
import 'package:photo_redactor/presentation/widgets/Card_widget.dart';
import 'package:photo_redactor/presentation/widgets/drawer_widget.dart';

class AllWorksPage extends StatefulWidget {
  const AllWorksPage({super.key});

  @override
  State<AllWorksPage> createState() => _AllWorksPageState();
}

class _AllWorksPageState extends State<AllWorksPage> {
  var read;

  @override
  void initState() {
    read = context.read<WorkBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    read.add(GetAllWorksEvent());
    return Scaffold(
      drawer: myDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('My works'),
        centerTitle: true,
      ),
      body: BlocConsumer<WorkBloc, WorkState>(
          bloc: read,
          listener: (context, state) {},
          builder: (context, state) {
            if (state is EmptyWorkState) {
              return const Center(
                child: Text('База пуста'),
              );
            }

            if (state is LoadingWorkState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LoadedWorkState) {
              if (state.works.isEmpty) {
                return const Center(
                  child: Text('База пуста. Сохраните свою первую работу'),
                );
              } else {
                return ListView.builder(
                  itemCount: state.works.length,
                  itemBuilder: (context, index) => CardWidget(
                    workModel: state.works[index],
                    index: index,
                  ),
                );
              }
            }
            return const SizedBox.shrink();
          }),
    );
  }
}
