/*
- Author: Iván Maldonado (Kikemaldonado11@gmail.com)
- Develop at: March 2025
*/

import 'package:flutter/cupertino.dart';
import 'package:be_fit/database/Database.dart';
import 'package:be_fit/models/Profile.dart';

class ProfileServer with ChangeNotifier {
  Profile? _profile;


  // Getters
  Profile? get profile => _profile;


  // Get profile
  Future<Profile?> getProfile() async {
    try {
      _profile = await DBProvider.db.readProfile();
      notifyListeners();
      return _profile;
    } catch (e) {
      return null;
    }
  }

  // Profile exists
  Future<bool?> profileExists() async {
    try{
      _profile= await DBProvider.db.readProfile();
      if (_profile != null){
        return true;
      }
    } catch (e){
      return false;
    }
    return null;
  }

  // Insert profile
  Future<String> insertProfile(Profile profile) async {
    try {
      await DBProvider.db.insertProfile(profile);
    } catch(e){
      return e.toString();
    }
    return 'Ok';
  }

  // Update profile
  Future<String> updateProfile(Profile profile) async {
    try {
      await DBProvider.db.updateProfile(profile);
    } catch(e){
      return e.toString();
    }
    return 'Ok';
  }

}