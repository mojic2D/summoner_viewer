import 'package:flutter/material.dart';
import 'package:summoner_viewer/common_widgets/cards/summoner_info_display_card.dart';
import 'package:summoner_viewer/common_widgets/text_styles/text_styles.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';

class BaseSummonerInformationCard extends StatelessWidget {

  BaseSummonerInformationCard({@required this.summoner});

  final Summoner summoner;

  @override
  Widget build(BuildContext context) {
    return SummonerInfoDisplayCard(
      imageAsset: 'assets/profileicon/${summoner.profileIconId}.png',
      columnChildren: [
        Text(
          '${summoner.name}',
          style: TextStyles.summonerName,
        ),
        SizedBox(
          height: 10,
        ),
        Row(children: [
          Text(
            'Summoner level:',
            style: TextStyles.summonerLevel,
          ),
          Text(
            ' ${summoner.summonerLevel}',
            style: TextStyles.summonerLevelBlue,
          ),
        ]),

      ],
    );
  }


}
