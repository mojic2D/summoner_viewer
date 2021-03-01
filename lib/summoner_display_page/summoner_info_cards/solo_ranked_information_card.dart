import 'package:flutter/material.dart';
import 'package:summoner_viewer/common_widgets/cards/summoner_info_display_card.dart';
import 'package:summoner_viewer/common_widgets/text_styles/text_styles.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';

class SoloRankedInformationCard extends StatelessWidget {

  SoloRankedInformationCard({@required this.summoner});

  final Summoner summoner;

  @override
  Widget build(BuildContext context) {
    return SummonerInfoDisplayCard(
      imageAsset: 'assets/ranked-emblems/Emblem_${summoner.soloRank.tier}.png',
      columnChildren: [
        SizedBox(height: 5.0),
        Text(
          '${summoner.soloRank.queueType}',
          style: TextStyles.lightGrey14,
        ),
        SizedBox(height: 5.0),
        Text(
          '${summoner.soloRank.tier}  ${summoner.soloRank.rank}',
          style: TextStyles.rankAndTierBlue,
        ),
        SizedBox(height: 5.0),
        Row(
          children: [
            Text(
              '${summoner.soloRank.leaguePoints} LP',
              style: TextStyles.slightlyBolderBlack,
            ),
            Text(
              ' / ${summoner.soloRank.wins}W ${summoner.soloRank.losses}L',
              style: TextStyles.lightGrey15,
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          'Win Ratio ${summoner.soloRank.winRatio}%',
          style: TextStyles.lightGrey15,
        ),
        SizedBox(height: 5.0),
        Text(
          '${summoner.soloRank.leagueName}',
          style: TextStyles.lightGrey15,
        ),
      ],
    );
  }
}
