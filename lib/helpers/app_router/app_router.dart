import '../../business_logic_layer/cubit/characters_cubit.dart';
import '../../data_layer/model/character_model.dart';
import '../../data_layer/repository/character_reposotory.dart';
import '../../data_layer/web_service_api.dart/web_service_character.dart';
import 'routes.dart';
import '../../presentation_layer/screens/character_details.dart';
import '../../presentation_layer/screens/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharacterReposotory characterReposotory;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterReposotory = CharacterReposotory(
      webServiceCharacter: WebServiceCharacter(),
    );
    charactersCubit = CharactersCubit(characterReposotory);
  }

  Route? onGerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => charactersCubit,
                child: CharacterScreen(),
              ),
        );
      case characterDetails:
        Character character = settings.arguments as Character;
        return MaterialPageRoute(
          builder: (context) => CharacterDetails(character: character),
        );
    }
    return null;
  }
}
