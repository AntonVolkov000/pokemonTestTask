import 'package:flutter/material.dart';
import 'package:pokemon_test_task/pages/pokemon.dart';
import 'package:pokemon_test_task/pages/pokemon_bloc.dart';

class Styles {
  static TextStyle getTextStyle() {
    return const TextStyle(
      fontSize: 30,
      color: Colors.white,
    );
  }

  static ButtonStyle getElevatedButtonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xffef5350),
      minimumSize: const Size(150, 50)
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/search');
                },
                style: Styles.getElevatedButtonStyle(),
                child: Text('Search', style: Styles.getTextStyle()),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/random');
                },
                style: Styles.getElevatedButtonStyle(),
                child: Text('Random', style: Styles.getTextStyle()),
              ),
            ],
          ),
      backgroundColor: const Color(0xffd54a48),
    );
  }
}

class StreamBuilderWidget extends StatelessWidget {
  const StreamBuilderWidget({Key? key, required this.pokemonBloc}) : super(key: key);
  
  final PokemonBloc pokemonBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: pokemonBloc.pokemon,
      initialData: Pokemon(),
      builder: (BuildContext context, AsyncSnapshot<Pokemon> snapshot) {
        return Column(
          children: [
            Text('${snapshot.data?.findInfo}', style: Styles.getTextStyle()),
            Text('${snapshot.data?.name}', style: Styles.getTextStyle()),
            Text('${snapshot.data?.baseExperience}', style: Styles.getTextStyle()),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text('${snapshot.data?.abilities}', style: Styles.getTextStyle())
                  ],
                ),
                Column(
                  children: snapshot.data?.abilityList as List<Text>,
                )
              ],
            )
          ],
        );
      },
    );
  }
}

class PageWidget extends StatelessWidget {
  const PageWidget({Key? key, required this.pokemonBloc, required this.bottomComponent})
      : super(key: key);
  
  final PokemonBloc pokemonBloc;
  final Row bottomComponent;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd54a48),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(58),
        child: AppBarWidget(),
      ),
      body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 40, bottom: 40),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilderWidget(pokemonBloc: pokemonBloc)
                    ],
                  ),
                  bottomComponent
                ]
            ),
          )
      ),
    );
  }
}
