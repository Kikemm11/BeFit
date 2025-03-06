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
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/user-form': (context) => UserFormScreen(),
        '/': (context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}