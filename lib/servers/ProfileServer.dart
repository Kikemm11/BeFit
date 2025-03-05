/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/Profile.dart';

class ProfileServer with ChangeNotifier {
  List<Profile> _profiles = [];
  Profile? _currentProfile;


  // Getters
  List<Profile> get profiles => _profiles;
  Profile? get _currentProfile => _currentProfile;


  // Get all the products
  Future<String> getAllProfiles() async {
    try {
      _profiles = await DBProvider.db.readAllProfiles();
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return 'Ok';
  }

// Get one product given its id
  Future<Profile?> getOneProfile(int ProfileId) async {
    try {
      _currentProfile = await DBProvider.db.readOneProfile(profileId);
      notifyListeners();
      return _currentProfile;
    } catch (e) {
      return null;
    }
  }


}