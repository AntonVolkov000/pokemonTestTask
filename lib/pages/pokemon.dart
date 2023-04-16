import 'package:flutter/cupertino.dart';

class Pokemon {
  String _findInfo = '';
  String _name = '';
  String _baseExperience = '';
  String _abilities = '';
  List<Text> _abilityList = [];

  String get findInfo => _findInfo;
  String get name => _name;
  String get baseExperience => _baseExperience;
  String get abilities => _abilities;
  List<Text> get abilityList => _abilityList;

  set findInfo(String value) => _findInfo = value;
  set name(String value) => _name = value;
  set baseExperience(String value) => _baseExperience = value;
  set abilities(String value) => _abilities = value;
  set abilityList(List<Text> value) => _abilityList = value;

  void clearAbilityList() {
    _abilityList.clear();
  }
}
