import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';
import 'package:summoner_viewer/summoner_display_page/summoner_info_cards/base_summoner_information_card.dart';
import 'package:summoner_viewer/summoner_display_page/summoner_info_cards/flex_ranked_information_card.dart';
import 'file:///C:/Users/Mojic/AndroidStudioProjects/summoner_viewer/lib/summoner_display_page/summoner_info_cards/match_history/match_history_card.dart';
import 'package:summoner_viewer/summoner_display_page/summoner_info_cards/solo_ranked_information_card.dart';
import 'package:summoner_viewer/summoner_display_page/summoner_info_cards/unranked_ranked_information_card.dart';

class SummonerDisplayPage extends StatelessWidget {
  SummonerDisplayPage({@required this.summoner});
  final Summoner summoner;
  _buildChildren() {
    if (Platform.isWindows || kIsWeb) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            BaseSummonerInformationCard(summoner: summoner),
            summoner.soloRank.tier == 'Unranked'
                ? UnrankedRankedInformationCard(rankedType: 'Ranked Solo')
                : SoloRankedInformationCard(summoner: summoner),
            summoner.flexRank.tier == 'Unranked'
                ? UnrankedRankedInformationCard(rankedType: 'Ranked Flex')
                : FlexRankedInformationCard(summoner: summoner),
          ]),
          MatchHistoryCard(summoner: summoner),
          SizedBox(height: 50),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BaseSummonerInformationCard(summoner: summoner),
          summoner.soloRank.tier == 'Unranked'
              ? UnrankedRankedInformationCard(rankedType: 'Ranked Solo')
              : SoloRankedInformationCard(summoner: summoner),
          summoner.flexRank.tier == 'Unranked'
              ? UnrankedRankedInformationCard(rankedType: 'Ranked Flex')
              : FlexRankedInformationCard(summoner: summoner),
          MatchHistoryCard(summoner: summoner),
          SizedBox(height: 50),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summoner information'),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: _buildChildren(),
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
