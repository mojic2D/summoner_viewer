import 'package:flutter/cupertino.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner_info_converts.dart';

class ChallengerPlayer {
  ChallengerPlayer(
      {@required this.summonerName,
      @required this.wins,
      @required this.losses,
      @required this.leaguePoints
    }):winRatio=SummonerInfoConverts.calculateWinRatio(wins, losses);

  final String summonerName;
  final int wins;
  final int losses;
  final int leaguePoints;
  final double winRatio;
}
