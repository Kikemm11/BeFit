/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/Biotype.dart';

class BiotypeServer with ChangeNotifier {
  List<Biotype> _biotypes = [];
  Biotype? _currentBiotype;


  // Getters
  List<Biotype> get biotypes => _biotypes;
  Biotype? get currentBiotype => _currentBiotype;


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

  // Get one biotype by the given id
  Future<Biotype?> getOneBiotype(int biotypeId) async {
    try {
      _currentBiotype = await DBProvider.db.readOneBiotype(biotypeId);
      notifyListeners();
      return _currentBiotype;
    } catch (e) {
      return null;
    }
  }

}