import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:summoner_viewer/common_widgets/text_styles/text_styles.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner_single_match_history.dart';

class SingleMatchHistoryCard extends StatelessWidget {
  SingleMatchHistoryCard({@required this.matchHistoryData});

  final SummonerSingleMatchHistory matchHistoryData;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(
          color: Colors.grey,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          width: Platform.isWindows || kIsWeb?350:null,
          color: matchHistoryData.win
              ? Colors.blue[100]
              : Color.fromRGBO(226, 182, 179, 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    '${matchHistoryData.gameCreation}',
                    style: TextStyles.lightGrey15,
                  ),
                  matchHistoryData.win
                      ? Text(
                          'VICTORY',
                          style: TextStyles.blueBlue,
                        )
                      : Text(
                          'DEFEAT',
                          style: TextStyles.redRed,
                        ),
                  Text('Duration ${matchHistoryData.gameDuration}m'),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/champion_tiles/${matchHistoryData.champion}_0.jpg',
                  width: 50,
                  height: 50,
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${matchHistoryData.kills}/',
                        style: TextStyles.lighterGreyBold,
                      ),
                      Text(
                        '${matchHistoryData.deaths}',
                        style: TextStyles.bigRedRed,
                      ),
                      Text(
                        '/${matchHistoryData.assists}',
                        style: TextStyles.lighterGreyBold,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('${matchHistoryData.kda}:1 ',
                          style: TextStyles.slightlyBolderBlack),
                      Text(
                        'KDA',
                        style: TextStyles.grey14,
                      )
                    ],
                  ),
                ],
              ),
              Column(children: [
                Text('Level ${matchHistoryData.champLevel}',
                    style: TextStyles.lightGrey15),
                Text(
                  '${matchHistoryData.goldEarned.toStringAsFixed(2)}K G',
                  style: matchHistoryData.win
                      ? TextStyles.yellowForGold
                      : TextStyles.blueForGold,
                ),
                Text('${matchHistoryData.creepScore} CS'),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
