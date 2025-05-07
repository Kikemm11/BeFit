import 'package:be_fit/models/models.dart';
import 'package:be_fit/routes/ProgressScreen.dart';
import 'package:be_fit/routes/SessionFormScreen.dart';
import 'package:be_fit/routes/TrainingPlanScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:be_fit/routes/routes.dart';
import 'package:be_fit/servers/servers.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BiotypeServer()),
          ChangeNotifierProvider(create: (context) => ExerciseServer()),
          ChangeNotifierProvider(create: (context) => MuscleGroupServer()),
          ChangeNotifierProvider(create: (context) => ProfileServer()),
          ChangeNotifierProvider(create: (context) => TrainingPlanExerciseServer()),
          ChangeNotifierProvider(create: (context) => TrainingPlanInfoServer()),
          ChangeNotifierProvider(create: (context) => TrainingPlanServer()),
          ChangeNotifierProvider(create: (context) => TrainingSessionServer()),
        ],
        child: BeFit(),
      ),
  );
}

class BeFit extends StatelessWidget {
  const BeFit({super.key});

  // Routes definition and main config
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BeFit',
      theme: ThemeData(useMaterial3: true),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/user-form': (context) => UserFormScreen(),
        '/': (context) => HomeScreen(),
        '/progress': (context) => ProgressScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/training-plan') {
          final trainingPlan = settings.arguments as TrainingPlan;
          return MaterialPageRoute(
            builder: (context) => TrainingPlanScreen(trainingPlan: trainingPlan),
          );
        }
        if (settings.name == '/session'){
          final args = settings.arguments as Map<String, dynamic>;
          final session = args['session'] as TrainingSession;
          final trainingPlan = args['trainingPlan'] as TrainingPlan;
          return MaterialPageRoute(
            builder: (context) => SessionFormScreen(session: session, trainingPlan: trainingPlan,),
          );
        }
        return null; // fallback
      },
      debugShowCheckedModeBanner: false,
    );
  }
}