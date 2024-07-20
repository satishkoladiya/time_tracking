import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracking/data/trackable_completed_task.dart';
import 'package:time_tracking/list/list_view_model.dart';
import 'package:time_tracking/repository/task_repository.dart';

final completedTasksViewModelProvider = Provider.family.autoDispose(
  (ref, String id) {
    final vm = CompletedTasksViewModel(
      taskRepository: ref.watch(taskRepositoryProvider),
      id: id,
    );
    ref.onDispose(vm.dispose);
    return vm;
  },
);

class CompletedTasksViewModel extends ListViewModel<TrackableCompletedTask> {
  final TaskRepository taskRepository;
  final String id;
  CompletedTasksViewModel({required this.taskRepository, required this.id});
  @override
  Future<List<TrackableCompletedTask>> fetchData(
    int pageNumber,
    int pageSize,
  ) {
    return taskRepository.getCompletedTasks(
      projectId: id,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
