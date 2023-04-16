import 'package:flutter/material.dart';
import 'package:pokemon_test_task/pages/common_components.dart';
import 'package:pokemon_test_task/pages/pokemon_bloc.dart';
import 'package:pokemon_test_task/pages/pokemon_event.dart';

class RandomPokemon extends StatefulWidget {
  const RandomPokemon({Key? key}) : super(key: key);

  @override
  State<RandomPokemon> createState() => _RandomPokemonState();
}

class _RandomPokemonState extends State<RandomPokemon> {

  final _randomPokemonBloc = PokemonBloc();

  @override
  Widget build(BuildContext context) {
    final Row bottomComponent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            _randomPokemonBloc.pokemonEventSink.add(RandomPokemonEvent());
          },
          style: Styles.getElevatedButtonStyle(),
          child: Text('Random', style: Styles.getTextStyle()),
        )
      ],
    );

    return PageWidget(pokemonBloc: _randomPokemonBloc,
        bottomComponent: bottomComponent);
  }

  @override
  void dispose() {
    super.dispose();
    _randomPokemonBloc.dispose();
  }
}
