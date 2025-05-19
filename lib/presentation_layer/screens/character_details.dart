import 'package:bloc_first_app/presentation_layer/widget/loader.dart';
import 'package:bloc_first_app/presentation_layer/widget/no_internet.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../data_layer/model/character_model.dart';
import '../../helpers/colors/colors.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatefulWidget {
  final Character character;
  const CharacterDetails({super.key, required this.character});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          widget.character.name,
          style: TextStyle(
            color: MyColors.myWhite,
            overflow: TextOverflow.ellipsis,
            fontSize: 18,
          ),
        ),
        background: Hero(
          tag: widget.character.id,
          child: Image.network(widget.character.image, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(color: MyColors.myWhite, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: OfflineBuilder(
        connectivityBuilder: (context, value, child) {
          final bool connected = !value.contains(ConnectivityResult.none);
          return connected
              ? CustomScrollView(
                slivers: [
                  buildSliverAppBar(),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            characterInfo("Status : ", widget.character.status),
                            buildDivider(255),
                            characterInfo(
                              "Species : ",
                              widget.character.species,
                            ),
                            buildDivider(240),
                            characterInfo("Type : ", widget.character.type),
                            buildDivider(270),
                            characterInfo("Gender : ", widget.character.gender),
                            buildDivider(250),
                            characterInfo(
                              "Origin : ",
                              widget.character.origin.name,
                            ),
                            buildDivider(260),
                            characterInfo(
                              "Location : ",
                              widget.character.location.name,
                            ),
                            buildDivider(240),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              )
              : NoInternet();
        },
        child: Loader(),
      ),
    );
  }
}
