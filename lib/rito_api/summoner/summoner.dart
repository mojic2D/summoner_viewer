import 'package:flutter/cupertino.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner_ranked.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner_single_match_history.dart';

class Summoner {
  Summoner({
    @required this.id,
    @required this.accountId,
    @required this.name,
    @required this.summonerLevel,
    @required this.profileIconId,
    this.soloRank,
    this.flexRank,
    this.matchHistory,
  })  : assert(id != null),
        assert(name != null),
        assert(summonerLevel != null);

  final String id;
  final String accountId;
  final String name;
  final int summonerLevel;
  final int profileIconId;
  final SummonerRanked soloRank;
  final SummonerRanked flexRank;
  final List<SummonerSingleMatchHistory> matchHistory;

  static Summoner createSummoner(Map<String, dynamic> summonerData,
      SummonerRanked soloRanked, SummonerRanked flexRanked,
      [List<SummonerSingleMatchHistory> matchHistory]) {
    return Summoner(
      id: summonerData['id'],
      accountId: summonerData['accountId'],
      name: summonerData['name'],
      summonerLevel: summonerData['summonerLevel'],
      profileIconId: summonerData['profileIconId'],
      soloRank: soloRanked,
      flexRank: flexRanked,
      matchHistory: matchHistory,
    );
  }
}
