import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokemon_test_task/pages/pokemon.dart';
import 'package:pokemon_test_task/pages/pokemon_event.dart';
import 'package:pokemon_test_task/pages/common_components.dart';
import 'dart:math';

const String _baseUrl = 'https://pokeapi.co/api/v2/';

class PokemonBloc {
  Pokemon _pokemon = Pokemon();

  final _pokemonStateController = StreamController<Pokemon>();
  StreamSink<Pokemon> get _inPokemon => _pokemonStateController.sink;
  Stream<Pokemon> get pokemon => _pokemonStateController.stream;

  final _pokemonEventController = StreamController<PokemonEvent>();
  Sink<PokemonEvent> get pokemonEventSink => _pokemonEventController.sink;

  PokemonBloc() {
    _pokemonEventController.stream.listen(_mapEventToState);
  }

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
    _fillPokemon(response);
  }

  Future<void> _setPokemonByName(String pokemonName) async {
    String information = '';
    Response? response;
    if (double.tryParse(pokemonName) != null) {
      information = 'Pokemon not found';
    } else {
      try {
        response = await _dio.get('pokemon/$pokemonName');
      } on DioError catch (e) {
        if (e.response?.statusCode == 404) {
          information = 'Pokemon not found';
        }
      }
    }
    _pokemon.findInfo = information;
    if (information == '') {
      _fillPokemon(response);
    }
  }
  
  void _fillPokemon(Response? response) {
    if (response?.data['name'] != null) {
      _pokemon.name = 'Name: ${response?.data['name']}';
    }
    if (response?.data['base_experience'] != null) {
      _pokemon.baseExperience = 'Base experience: ${response?.data['base_experience']}';
    }
    if (response?.data['abilities'] != null) {
      _pokemon.abilities = 'Abilities: ';
      _pokemon.clearAbilityList();
      List<Text> abilityList = [];
      for (Map ability in response?.data['abilities']) {
        String abilityName = ability['ability']['name'];
        abilityList.add(Text(abilityName, style: Styles.getTextStyle()));
      }
      _pokemon.abilityList = abilityList;
    }
  }

  Future<void> _mapEventToState(PokemonEvent event) async {
    _pokemon = Pokemon();
    if (event is RandomPokemonEvent) {
      await _setRandomPokemon();
    } else {
      await _setPokemonByName((event as SearchPokemonEvent).pokemonName);
    }
    _inPokemon.add(_pokemon);
  }

  void dispose() {
    _pokemonStateController.close();
    _pokemonEventController.close();
  }
}
