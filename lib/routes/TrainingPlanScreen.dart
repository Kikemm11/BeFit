import 'package:be_fit/widgets/BeFitCreateTrainingPlanAlertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:be_fit/models/models.dart';
import 'package:be_fit/servers/servers.dart';

import '../widgets/BeFitTrainingSessionCardWidget.dart';
import '../widgets/TrainingExercisesDialogWidget.dart';

class TrainingPlanScreen extends StatefulWidget {
  final TrainingPlan trainingPlan;

  TrainingPlanScreen({
    required this.trainingPlan
});


  @override
  _TrainingPlanScreenState createState() => _TrainingPlanScreenState(trainingPlan: trainingPlan);
}

class _TrainingPlanScreenState extends State<TrainingPlanScreen> {
  final TrainingPlan trainingPlan;

  _TrainingPlanScreenState({
    required this.trainingPlan
});

  Profile? profile;
  TrainingPlanInfo? upperPlan;
  TrainingPlanInfo? bottomPlan;
  TrainingPlanInfo? absPlan;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    profile = context.read<ProfileServer>().profile!;
    _fetchTrainingPlanSessions(trainingPlan.id);
  }


  // Get profile
  Future<void> _fetchProfile() async {
    await context.read<ProfileServer>().getProfile();
  }

  // Get biotype
  Future<void> _fetchBiotype(biotypeId) async {
    await context.read<BiotypeServer>().getOneBiotype(biotypeId);
  }

  // Get training sessions given a plan
  Future<void> _fetchTrainingPlanSessions(trainingPlanId) async {
    await context.read<TrainingSessionServer>().getTrainingSessionsPlan(trainingPlanId);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0)
      {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return BeFitTrainingExercisesDialog(trainingPlanInfoId: trainingPlan.id!);
          },
        );
      }
    else if (_selectedIndex == 1)
      {
        Navigator.pushNamed(context, '/user-form');
      }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('BeFit'),
            backgroundColor: Colors.cyan[600],
          ),
          drawer: Consumer<ProfileServer>(
              builder: (context, value, child){
                _fetchBiotype(value.profile!.biotypeId);
                return Drawer(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.cyan[600]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Perfil',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 4),
                              Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30, // Slightly smaller icon
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(title: Text('Nombre: ${value.profile!.name}'), onTap: () {}),
                            Divider(thickness: 0.1),
                            ListTile(title: Text('Edad: ${value.profile!.age.toString()}'), onTap: () {}),
                            Divider(thickness: 0.5),
                            ListTile(title: Text('Género: ${ (value.profile!.genre == 'M') ? 'Masculino' : 'Femenino'}'), onTap: () {}),
                            Divider(thickness: 0.2),
                            Consumer<BiotypeServer>(
                                builder: (context, biotypeValue, child){
                                  return ListTile(title: Text('Biotipo: ${biotypeValue.currentBiotype!.name}'), onTap: () {});
                                }
                            ),
                            Divider(thickness: 0.5),
                            ListTile(title: Text('Altura: ${value.profile!.height.toString()} mts'), onTap: () {}),
                            Divider(thickness: 0.5),
                            ListTile(title: Text('Peso: ${value.profile!.weight.toString()} Kg'), onTap: () {}),
                            Divider(thickness: 0.5),
                            ListTile(title: Text('Circunferencia Braquial: ${value.profile!.armMeasure.toString()} cm'), onTap: () {}),
                            Divider(thickness: 0.5),
                            ListTile(title: Text('Circunferencia de muslo: ${value.profile!.legMeasure.toString()} cm'), onTap: () {}),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
          body: Consumer<TrainingSessionServer>(
              builder: (context, value, child){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Center(
                        child: Text(
                          "Sesiones de Entrenamiento",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: value.trainingSessions.length,
                          itemBuilder: (context, index) {
                            return TrainingSessionCardWidget(session: value.trainingSessions[index], trainingPlan: trainingPlan);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
          ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center),
              label: 'Ejercicios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Progreso',
            ),
          ],
        ),
      ),
    );
  }
}
