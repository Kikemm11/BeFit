import 'package:be_fit/widgets/BeFitCreateTrainingPlanAlertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:be_fit/models/models.dart';
import 'package:be_fit/servers/servers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _leftIsPressed = false;
  bool _upperRightIsPressed = false;
  bool _downRightIsPressed = false;

  Profile? profile;
  TrainingPlanInfo? upperPlan;
  TrainingPlanInfo? bottomPlan;
  TrainingPlanInfo? absPlan;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    profile = context.read<ProfileServer>().profile!;
    _fetchTrainingPlans(profile!);
  }


  // Get profile
  Future<void> _fetchProfile() async {
    await context.read<ProfileServer>().getProfile();
  }

  // Get biotype
  Future<void> _fetchBiotype(biotypeId) async {
    await context.read<BiotypeServer>().getOneBiotype(biotypeId);
  }

  // Get training plans
  Future<void> _fetchTrainingPlans(Profile profile) async {
    List<TrainingPlanInfo?> trainingPlansInfo = await context.read<TrainingPlanInfoServer>().getTrainingPlansInfoByBiotypeAndGenre(profile.biotypeId, profile.genre);
    setState(() {
      upperPlan = trainingPlansInfo[0];
      absPlan = trainingPlansInfo[1];
      bottomPlan = trainingPlansInfo[2];
    });

    await context.read<TrainingPlanServer>().getUpperBodyTrainingPlanByInfo(trainingPlansInfo[0]!.id!);
    await context.read<TrainingPlanServer>().getAbsBodyTrainingPlanByInfo(trainingPlansInfo[1]!.id!);
    await context.read<TrainingPlanServer>().getBottomBodyTrainingPlanByInfo(trainingPlansInfo[2]!.id!);
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
        body: Consumer<ProfileServer>(
          builder: (context, profileValue, child){

            return Consumer<TrainingPlanServer>(
                builder: (context, trainingPlanValue, child){

                  final upperBodyPlan = trainingPlanValue.upperBodyTrainingPlan;
                  final bottomBodyPlan = trainingPlanValue.bottomBodyTrainingPlan;
                  final absPlan = trainingPlanValue.absTrainingPlan;

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [

                              // Left side: Taller container

                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _leftIsPressed = !_leftIsPressed;
                                    });
                                  },
                                  onLongPress: (){
                                    if (bottomBodyPlan != null)
                                      {
                                        _showDeleteBottomSheet(context, bottomBodyPlan);
                                      }
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Card(
                                    color: (bottomBodyPlan != null) ? Color(0xFFa2e4ec) : Color(0xFFE3E7EC) ,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      height: constraints.maxHeight,
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.airline_seat_legroom_extra,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            'Tren Inferior',
                                            style: TextStyle(color: Colors.white, fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 5),

                              // Right side

                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [

                                    // Upper right container

                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _upperRightIsPressed = !_upperRightIsPressed;
                                          });
                                        },
                                        onLongPress: (){
                                          if (upperBodyPlan != null)
                                          {
                                            _showDeleteBottomSheet(context, upperBodyPlan);
                                          }
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Card(
                                          color: (upperBodyPlan != null) ? Color(0xFFa2e4ec) : Color(0xFFE3E7EC),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            height: constraints.maxHeight,
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  CupertinoIcons.person,
                                                  color: Colors.white,
                                                  size: 50,
                                                ),
                                                SizedBox(height: 20),
                                                Text(
                                                  'Tren Superior',
                                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 5),

                                    // Lower right container

                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _downRightIsPressed = !_downRightIsPressed;
                                          });
                                        },
                                        onLongPress: (){
                                          if (absPlan != null)
                                          {
                                            _showDeleteBottomSheet(context, absPlan);
                                          }
                                        },
                                        behavior: HitTestBehavior.opaque,
                                        child: Card(
                                          color: (absPlan != null) ? Color(0xFFa2e4ec) : Color(0xFFE3E7EC),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Container(
                                            height: constraints.maxHeight,
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.fitness_center,
                                                  color: Colors.white,
                                                  size: 50,
                                                ),
                                                SizedBox(height: 20),
                                                Text(
                                                  'Abdómen',
                                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
            );
          }
        ),
        floatingActionButton: Consumer<TrainingPlanInfoServer>(
          builder: (context, value, child){
            return FloatingActionButton(
              onPressed: () async {
                final bool result = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BeFitCreateTrainingPlanAlertDialog(
                                    upperBodyPlan: value.trainingPlanInfos[0],
                                    bottomBodyPlan: value.trainingPlanInfos[2],
                                    absPlan: value.trainingPlanInfos[1]
                                );
                              },
                            );
                if (result)
                  {
                    _fetchTrainingPlans(profile!);
                  }

              },
              backgroundColor: Colors.cyan[200],
              child: Icon(Icons.fitness_center_outlined, color: Colors.blue,),
            );
          }
        )
      ),
    );
  }


  void _showDeleteBottomSheet(BuildContext context, TrainingPlan trainingPlan) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Eliminar', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showConfirmDeleteDialog(context, trainingPlan);
            },
          ),
        );
      },
    );
  }


  void _showConfirmDeleteDialog(BuildContext context, TrainingPlan trainingPlan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Eliminar este plan?'),
          content: const Text('Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Eliminar'),
              onPressed: () async {
                String result = await context.read<TrainingPlanServer>().deleteTrainingPlan(trainingPlan);

                if (result == 'Ok')
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Plan eliminado correctamente!'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );

                    setState(() {
                      _fetchTrainingPlans(profile!);
                    });
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ups! Ha ocurrido un error eliminando el plan'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                Navigator.of(context).pop();

                // Call your delete logic here
              },
            ),
          ],
        );
      },
    );
  }



}
