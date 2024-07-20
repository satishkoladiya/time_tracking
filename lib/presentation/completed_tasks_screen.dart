import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:time_tracking/list/list_view.dart';
import 'package:time_tracking/utilities/context_x.dart';
import 'package:time_tracking/view_models/completed_tasks_view_model.dart';

class CompletedTasksScreen extends StatefulWidget {
  final String projectId;
  const CompletedTasksScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  void initState() {
    super.initState();
    container.read(completedTasksViewModelProvider(widget.projectId)).init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final vm = ref.watch(completedTasksViewModelProvider(widget.projectId));
        return Scaffold(
          appBar: AppBar(title: const Text('Completed Tasks')),
          body: IListView(
            viewModel: vm,
            itemBuilder: (context, index) {
              final trackableTask = vm.state.items[index];
              return ListTile(
                title: Text(trackableTask.task.content),
                subtitle: trackableTask.trackingData.durationSpentInSec == 0
                    ? null
                    : Text(
                        'Duration:\n${prettyDuration(
                          Duration(
                            seconds:
                                trackableTask.trackingData.durationSpentInSec,
                          ),
                          abbreviated: true,
                        )}',
                      ),
                trailing: Text(
                  'Completed at\n${DateFormat.yMMMEd().format(trackableTask.task.completedAt.toLocal())}',
                ),
              );
            },
          ),
        );
      },
    );
  }
}
