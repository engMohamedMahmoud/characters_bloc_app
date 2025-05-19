part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharacterStateLoaded extends CharactersState {
  final List<Character> characters;
  CharacterStateLoaded({required this.characters});
}
