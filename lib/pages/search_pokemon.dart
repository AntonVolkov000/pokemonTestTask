import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_test_task/pages/common_components.dart';

const String _baseUrl = 'https://pokeapi.co/api/v2/';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({Key? key}) : super(key: key);

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {

  String _name = '';
  String _baseExperience = '';
  String _abilities = '';
  String _information = '';
  final List<Text> _abilityList = [];

  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final Dio _dio = Dio(BaseOptions(
      baseUrl: _baseUrl
  ));

  Future<void> _setPokemonByName(String pokemonName) async {
    setState(() {
      _information = '';
    });
    Response? response;
    try {
      response = await _dio.get('pokemon/$pokemonName');
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        setState(() {
          _information = 'Pokemon not found';
        });
      }
    }
    if (_information == '') {
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
  }

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
                  _setPokemonByName(pokemonName);
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
                _setPokemonByName(textController.text);
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
      child: PageTemplate(name: _name, baseExperience: _baseExperience,
          abilities: _abilities, abilityList: _abilityList,
          bottomComponent: bottomComponent, information: _information,),
    );
  }
}
