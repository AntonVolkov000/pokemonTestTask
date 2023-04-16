import 'package:flutter/material.dart';
import 'package:pokemon_test_task/pages/random_pokemon.dart';
import 'package:pokemon_test_task/pages/search_pokemon.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/random',
    routes: {
      '/random': (context) => const RandomPokemon(),
      '/search': (context) => const SearchPokemon(),
    },
  ));
}
