abstract class PokemonEvent {}

class RandomPokemonEvent extends PokemonEvent {}

class SearchPokemonEvent extends PokemonEvent {
  String _pokemonName = '';

  String get pokemonName => _pokemonName;
  set pokemonName(String value) => _pokemonName = value;

  SearchPokemonEvent(String pokemonName) {
    _pokemonName = pokemonName;
  }
}