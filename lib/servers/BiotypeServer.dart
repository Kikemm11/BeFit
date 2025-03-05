/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/Biotype.dart';

class BiotypeServer with ChangeNotifier {
  List<Biotype> _biotypes = [];


  // Getters
  List<Biotype> get biotypes => _biotypes;


  // Get all the products
  Future<String> getAllBiotypes() async {
    try {
      _biotypes = await DBProvider.db.readAllBiotypes();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

}