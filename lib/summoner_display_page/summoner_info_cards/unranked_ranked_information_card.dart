import 'package:flutter/material.dart';
import 'package:summoner_viewer/common_widgets/cards/summoner_info_display_card.dart';
import 'package:summoner_viewer/common_widgets/text_styles/text_styles.dart';

class UnrankedRankedInformationCard extends StatelessWidget {

  UnrankedRankedInformationCard({@required this.rankedType});

  final String rankedType;

  @override
  Widget build(BuildContext context) {
    return SummonerInfoDisplayCard(
      imageAsset: 'assets/ranked-emblems/Emblem_Unranked.png',
      columnChildren: [
        SizedBox(height:40),
        Text(
          '$rankedType',
          style: TextStyles.lightGrey14,
        ),
        Text(
          'Unranked',
          style: TextStyles.greyBold,
        ),
      ],
    );
  }
}
