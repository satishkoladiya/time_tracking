import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracking/service/local_storage.dart';
import 'package:time_tracking/view_models/task_view_model/task_view_model.dart';

import 'data/command/command.dart';
import 'data/command/command_args.dart';
import 'data/command/command_result.dart';
import 'data/comment.dart';
import 'data/completed_task.dart';
import 'data/project.dart';
import 'data/project_color.dart';
import 'data/section.dart';
import 'data/task.dart';
import 'data/trackable_completed_task.dart';
import 'data/trackable_task.dart';
import 'data/tracking_data.dart';

Future<ProviderContainer> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeMappers();
  final localStorage = await LocalStorage.init();
  final container = ProviderContainer(overrides: [
    localStorageProvider.overrideWithValue(localStorage),
  ]);

  return container;
}

void initializeMappers() {
  CommandMapper.ensureInitialized();
  CommandTypeMapper.ensureInitialized();
  CommandArgsMapper.ensureInitialized();
  ProjectAddCommandArgsMapper.ensureInitialized();
  SectionAddCommandArgsMapper.ensureInitialized();
  ItemReorderCommandItemPayloadMapper.ensureInitialized();
  ItemReorderCommandArgsMapper.ensureInitialized();
  ItemMoveCommandArgsMapper.ensureInitialized();
  ItemAddCommandArgsMapper.ensureInitialized();
  CommandResultMapper.ensureInitialized();
  CommentMapper.ensureInitialized();
  CompletedTaskMapper.ensureInitialized();
  ProjectMapper.ensureInitialized();
  ProjectColorMapper.ensureInitialized();
  SectionMapper.ensureInitialized();
  TaskMapper.ensureInitialized();
  TrackableCompletedTaskMapper.ensureInitialized();
  TrackableTaskMapper.ensureInitialized();
  TrackingDataMapper.ensureInitialized();
  TaskWithCommentsMapper.ensureInitialized();
}
