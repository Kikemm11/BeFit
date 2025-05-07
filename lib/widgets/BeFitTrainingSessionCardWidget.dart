import 'package:be_fit/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/TrainingSession.dart';

class TrainingSessionCardWidget extends StatelessWidget {
  final TrainingSession session;
  final TrainingPlan trainingPlan;

  const TrainingSessionCardWidget({Key? key, required this.session, required this.trainingPlan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final bool isToday = DateUtils.isSameDay(session.createdAt, today);
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    Color getCardColor()
    {
      if (session.done == true)
        {
          return Colors.green[100]!;
        }
      else if (session.createdAt.isBefore(today))
        {
          return Colors.grey;
        }
      else
        {
          return Colors.cyan[100]!;
        }
    }

    return Card(
      color: getCardColor(),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const Icon(Icons.fitness_center),
        title: Text('${formatter.format(session.createdAt)}'),
        trailing: isToday && !session.done! || true
            ? TextButton(
            onPressed: (){
              Navigator.pushNamed(
                context,
                '/session',
                arguments: {'session': session, 'trainingPlan': trainingPlan},
              );
            },
            child: Text(
              'Entrenar'
            )
        )
            : null,
      ),
    );
  }
}