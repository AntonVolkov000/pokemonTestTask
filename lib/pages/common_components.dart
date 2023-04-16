import 'package:flutter/material.dart';

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

class AppBarTemplate extends StatelessWidget {
  const AppBarTemplate({Key? key}) : super(key: key);

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


class PageTemplate extends StatelessWidget {
  const PageTemplate({Key? key, required this.name, required this.baseExperience,
    required this.abilities, required this.abilityList, required this.bottomComponent,
    required this.information})
      : super(key: key);

  final String information;
  final String name;
  final String baseExperience;
  final String abilities;
  final List<Text> abilityList;
  final Row bottomComponent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd54a48),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(58),
        child: AppBarTemplate(),
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
                      Column(
                        children: [
                          Text(information, style: Styles.getTextStyle()),
                          Text(name, style: Styles.getTextStyle()),
                          Text(baseExperience, style: Styles.getTextStyle()),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(abilities, style: Styles.getTextStyle()),
                                ],
                              ),
                              Column(
                                children: abilityList,
                              )
                            ],
                          )
                        ],
                      )
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


