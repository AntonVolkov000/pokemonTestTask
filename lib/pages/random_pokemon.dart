import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_test_task/pages/common_components.dart';
import 'dart:math';

const String _baseUrl = 'https://pokeapi.co/api/v2/';

class RandomPokemon extends StatefulWidget {
  const RandomPokemon({Key? key}) : super(key: key);

  @override
  State<RandomPokemon> createState() => _RandomPokemonState();
}

class _RandomPokemonState extends State<RandomPokemon> {

  String _name = '';
  String _baseExperience = '';
  String _abilities = '';
  final List<Text> _abilityList = [];


  final Dio _dio = Dio(BaseOptions(
      baseUrl: _baseUrl
  ));

  Future<Response?> _getRandomPokemon(count) async {
    Response? response;
    try {
      int randomPokemonId = 1 + Random().nextInt(count + 1);
      response = await _dio.get('pokemon/$randomPokemonId');
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        response = await _getRandomPokemon(count);
      }
    }
    return response;
  }

  Future<void> _setRandomPokemon() async {
    Response? response = await _dio.get('pokemon/');
    int count = response.data['count'];
    response = await _getRandomPokemon(count);
    setState(() {
      if (response?.data['name'] != null) {
        _name = 'Name: ${response?.data['name']}';
      }
      if (response?.data['base_experience'] != null) {
        _baseExperience = 'Base experience: ${response?.data['base_experience']}';
      }
      if (response?.data['abilities'] != null) {
        _abilities = 'Abilities: ';
        _abilityList.clear();
        for (Map ability in response?.data['abilities']) {
          String abilityName = ability['ability']['name'];
          _abilityList.add(Text(abilityName, style: Styles.getTextStyle()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Row bottomComponent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _setRandomPokemon();
          },
          style: Styles.getElevatedButtonStyle(),
          child: Text('Random', style: Styles.getTextStyle()),
        )
      ],
    );

    return PageTemplate(name: _name, baseExperience: _baseExperience,
        abilities: _abilities, abilityList: _abilityList,
        bottomComponent: bottomComponent, information: '',);
  }
}
