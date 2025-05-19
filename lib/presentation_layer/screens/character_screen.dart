import 'package:bloc_first_app/business_logic_layer/cubit/characters_cubit.dart';
import 'package:bloc_first_app/data_layer/model/character_model.dart';
import 'package:bloc_first_app/helpers/colors/colors.dart';
import 'package:bloc_first_app/presentation_layer/widget/character_item.dart';
import 'package:bloc_first_app/presentation_layer/widget/loader.dart';
import 'package:bloc_first_app/presentation_layer/widget/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchCharacters;
  bool isSearch = false;
  final TextEditingController searchController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        filterData(searchedCharacter);
      },
    );
  }

  filterData(String searchData) {
    searchCharacters =
        allCharacters
            .where((element) => element.name.toLowerCase().contains(searchData))
            .toList();
    setState(() {});
  }

  List<Widget> actionsAppBarIcons() {
    if (isSearch) {
      return [
        IconButton(
          onPressed: () {
            /// clear search controller
            _clearSearch();
          },
          icon: Icon(Icons.close),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            /// start search controller
            _startSearch();
          },
          icon: Icon(Icons.search),
        ),
      ];
    }
  }

  _startSearch() {
    ModalRoute.of(
      context,
    )!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _closeSearch));
    setState(() {
      isSearch = true;
    });
  }

  _clearSearch() {
    setState(() {
      searchController.clear();
    });
  }

  _closeSearch() {
    _clearSearch();
    setState(() {
      isSearch = false;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacterApi();
  }

  Widget blocBuild() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharacterStateLoaded) {
          allCharacters = state.characters;
          return buildLoadedListWidgets();
        } else {
          return Loader();
        }
      },
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(children: [buildCharactersList()]),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount:
          searchController.text.isEmpty
              ? allCharacters.length
              : searchCharacters.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        Character character =
            searchController.text.isEmpty
                ? allCharacters[index]
                : searchCharacters[index];
        return CharacterItem(character: character);
      },
    );
  }

  Widget titleTextAppBar() {
    return Text("Characters", style: TextStyle(color: MyColors.myGrey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearch ? _buildSearchField() : titleTextAppBar(),
        actions: actionsAppBarIcons(),
      ),

      body: OfflineBuilder(
        connectivityBuilder: (context, value, child) {
          final bool connected = !value.contains(ConnectivityResult.none);
          return (connected) ? blocBuild() : NoInternet();
        },
        child: Loader(),
      ),
    );
  }
}
