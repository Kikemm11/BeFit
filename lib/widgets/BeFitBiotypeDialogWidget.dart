import 'package:be_fit/models/Biotype.dart';
import 'package:be_fit/servers/ExerciseServer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart' as carousel;

class BeFitBiotypeDialog extends StatefulWidget {
  final Biotype biotype;

  const BeFitBiotypeDialog({
    Key? key,
    required this.biotype,
  }) : super(key: key);

  @override
  State<BeFitBiotypeDialog> createState() =>
      _BeFitBiotypeDialogState(biotype: biotype);
}

class _BeFitBiotypeDialogState
    extends State<BeFitBiotypeDialog> {
  final Biotype biotype;

  _BeFitBiotypeDialogState({
    required this.biotype
});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 350,
        height: 270,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${biotype.name}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    biotype.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        )
          ],
        ),
      ),
    );
  }
}
