import 'dart:math';

import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracking/presentation/completed_tasks_screen.dart';
import 'package:time_tracking/presentation/task_form_screen.dart';
import 'package:time_tracking/presentation/task_screen.dart';
import 'package:time_tracking/presentation/widgets/task_card_widget.dart';
import 'package:time_tracking/view_models/project_view_model.dart';

class BoardScreen extends StatefulWidget {
  final String projectId;
  const BoardScreen({
    super.key,
    required this.projectId,
  });

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final projectStructure = ref.watch(
          projectViewModelProvider(widget.projectId),
        );
        final controller = ref.watch(
          projectViewModelProvider(widget.projectId).notifier,
        );

        return projectStructure.when(
          data: (data) => Scaffold(
            appBar: AppBar(
              title: Text(
                data.project.name,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedTasksScreen(
                            projectId: widget.projectId,
                          );
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.done_all),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: AppFlowyBoard(
                controller: data.controller,
                groupConstraints: BoxConstraints.tightFor(
                  width: min(
                    MediaQuery.of(context).size.width * .7,
                    300,
                  ),
                ),
                config: AppFlowyBoardConfig(
                  groupBackgroundColor:
                      Theme.of(context).colorScheme.inversePrimary,
                ),
                headerBuilder: (context, groupData) {
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          groupData.headerData.groupName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => TaskFormScreen(
                                projectId: data.projectId,
                                sectionId: groupData.id,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  );
                },
                cardBuilder: (context, groupData, item) {
                  final cardData = (item as CardBoardItem);
                  return TaskCard(
                    key: ValueKey(cardData.id),
                    task: cardData.trackableTask,
                    onRun: () {
                      controller.startTracking(cardData);
                    },
                    onStop: () {
                      controller.stopTracking(cardData);
                    },
                    onComplete: () {
                      controller.completeTask(
                        cardData,
                      );
                    },
                    onDelete: () {
                      controller.deleteTask(
                        cardData,
                      );
                    },
                    onTab: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return TaskScreen(taskId: cardData.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          error: (error, stackTrace) => Scaffold(
            body: Center(
              child: TextButton.icon(
                onPressed: () {
                  ref.refresh(projectViewModelProvider(widget.projectId));
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Reload'),
              ),
            ),
          ),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
