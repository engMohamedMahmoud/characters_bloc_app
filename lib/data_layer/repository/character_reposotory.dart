import '../model/character_model.dart';
import '../web_service_api.dart/web_service_character.dart';

class CharacterReposotory {
  final WebServiceCharacter webServiceCharacter;
  CharacterReposotory({required this.webServiceCharacter});

  Future<List<Character>> getAllCharactersApi() async {
    final characters = await webServiceCharacter.getAllCharacters();
    return characters.map((e) => Character.fromJson(e)).toList();
  }
}
