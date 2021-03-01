import 'package:flutter/material.dart';
import 'package:summoner_viewer/common_widgets/cards/summoner_info_display_card.dart';
import 'package:summoner_viewer/common_widgets/text_styles/text_styles.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';

class FlexRankedInformationCard extends StatelessWidget {

  FlexRankedInformationCard({@required this.summoner});

  final Summoner summoner;

  @override
  Widget build(BuildContext context) {
    return SummonerInfoDisplayCard(
      imageAsset: 'assets/ranked-emblems/Emblem_${summoner.flexRank.tier}.png',
      imageHeight: 100,
      imageWidth: 100,
      columnChildren: [
        SizedBox(height: 5.0),
        Text(
          '${summoner.flexRank.queueType}',
          style: TextStyles.lightGrey14,
        ),
        SizedBox(height: 5.0),
        Text(
          '${summoner.flexRank.tier}  ${summoner.flexRank.rank}',
          style: TextStyles.rankAndTierBlue,
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Text(
              '${summoner.flexRank.leaguePoints} LP',
              style: TextStyles.slightlyBolderBlack,
            ),
            Text(
              ' / ${summoner.flexRank.wins}W ${summoner.flexRank.losses}L',
              style: TextStyles.lightGrey15,
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          'Win Ratio ${summoner.flexRank.winRatio}%',
          style: TextStyles.lightGrey15,
        ),
      ],
    );
  }
}
