import 'package:flutter/material.dart';
import 'package:pokemon_test_task/pages/common_components.dart';
import 'package:pokemon_test_task/pages/pokemon_bloc.dart';
import 'package:pokemon_test_task/pages/pokemon_event.dart';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({Key? key}) : super(key: key);

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {

  final _randomPokemonBloc = PokemonBloc();

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final Row bottomComponent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 20),
              child: TextField(
                onSubmitted: (pokemonName) {
                  _randomPokemonBloc.pokemonEventSink.add(SearchPokemonEvent(pokemonName));
                },
                style: const TextStyle(color: Colors.white),
                controller: textController,
                focusNode: focusNode,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  hintText: 'Enter pokemon name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                focusNode.unfocus();
                _randomPokemonBloc.pokemonEventSink.add(SearchPokemonEvent(textController.text));
              },
              style: Styles.getElevatedButtonStyle(),
              child: Text('Search', style: Styles.getTextStyle()),
            )
          ],
        ),
      ],
    );

    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: PageWidget(pokemonBloc: _randomPokemonBloc,
          bottomComponent: bottomComponent),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _randomPokemonBloc.dispose();
  }
}
