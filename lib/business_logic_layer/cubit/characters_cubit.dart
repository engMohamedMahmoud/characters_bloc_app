import 'package:bloc/bloc.dart';
import '../../data_layer/model/character_model.dart';
import '../../data_layer/repository/character_reposotory.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterReposotory characterReposotory;
  List<Character> characters = [];
  CharactersCubit(this.characterReposotory) : super(CharactersInitial());

  List<Character> getAllCharacterApi() {
    characterReposotory.getAllCharactersApi().then((characters) {
      emit(CharacterStateLoaded(characters: characters));
      this.characters = characters;
    });
    return characters;
  }
}
