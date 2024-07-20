import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracking/config/constants.dart';
import 'package:time_tracking/data/command/command.dart';
import 'package:time_tracking/data/command/command_args.dart';
import 'package:time_tracking/data/project.dart';
import 'package:time_tracking/data/project_color.dart';
import 'package:time_tracking/repository/sync_repository.dart';
import 'package:time_tracking/service/http_client.dart';
import 'package:time_tracking/utilities/future_x.dart';
import 'package:uuid/uuid.dart';

final projectRepositoryProvider = Provider(
  (ref) => ProjectRepository(
    ref.watch(httpClientProvider),
    ref.watch(syncRepositoryProvider),
  ),
);

class ProjectRepository {
  final Dio httpClient;
  final SyncRepository syncRepository;

  ProjectRepository(
    this.httpClient,
    this.syncRepository,
  );

  Future<List<Project>> getProjects() async {
    const path = '${Constants.apiV2Path}/projects';

    final response = await httpClient.get<List>(
      path,
    );

    return Project.fromList(response.data ?? []);
  }

  Future<Project> getProject(String id) async {
    final path = '${Constants.apiV2Path}/projects/$id';

    final response = await httpClient.get<Map>(
      path,
    );

    return Project.fromMap(response.data!.cast<String, dynamic>());
  }

  Future<Project> createProject(
    String name,
  ) async {
    final randomColor = ProjectColor.values[Random().nextInt(
      ProjectColor.values.length - 1,
    )];
    final uuid = Uuid().v4;
    final projectTempId = uuid();
    final addProjectCommand = Command(
      type: CommandType.projectAdd,
      uuid: uuid(),
      tempId: projectTempId,
      args: ProjectAddCommandArgs(
        name: name,
        color: randomColor,
        viewStyle: 'board',
      ),
    );
    final addSectionsCommands = [
      Command(
        type: CommandType.sectionAdd,
        uuid: uuid(),
        tempId: uuid(),
        args: SectionAddCommandArgs(
          name: 'To Do',
          projectId: projectTempId,
          sectionOrder: 0,
        ),
      ),
      Command(
        type: CommandType.sectionAdd,
        uuid: uuid(),
        tempId: uuid(),
        args: SectionAddCommandArgs(
          name: 'In Progress',
          projectId: projectTempId,
          sectionOrder: 1,
        ),
      ),
      Command(
        type: CommandType.sectionAdd,
        uuid: uuid(),
        tempId: uuid(),
        args: SectionAddCommandArgs(
          name: 'Done',
          projectId: projectTempId,
          sectionOrder: 2,
        ),
      ),
    ];

    final result = await syncRepository.syncCommands([
      addProjectCommand,
      ...addSectionsCommands,
    ]);

    final projectId = result.tempIdMapping[projectTempId]!;
    return await getProject(projectId);
  }

  Future<bool> deleteProject(String id) async {
    final path = '${Constants.apiV2Path}/projects/$id';
    final result = await httpClient.delete(path).result;
    return result.isValue;
  }
}
