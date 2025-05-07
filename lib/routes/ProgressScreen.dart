import 'package:be_fit/widgets/BeFitCreateTrainingPlanAlertDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:be_fit/models/models.dart';
import 'package:be_fit/servers/servers.dart';

import '../widgets/BeFitTrainingSessionCardWidget.dart';
import '../widgets/TrainingExercisesDialogWidget.dart';

class ProgressScreen extends StatefulWidget {

  //ProgressScreen({
  //});


  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  //_ProgressScreenState({
  //});

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('BeFit'),
          backgroundColor: Colors.cyan[600],
        ),
        body: Consumer<ExerciseServer>(
            builder: (context, value, child){

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          "Todavia falta jaja",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Image.asset('lib/assets/cesar.jpeg', height: 500,),
                      )
                    ],
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
