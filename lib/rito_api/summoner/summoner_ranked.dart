import 'package:summoner_viewer/rito_api/summoner/summoner_info_converts.dart';

class SummonerRanked {
  SummonerRanked({
    this.leaguePoints=0,
    this.wins=0,
    this.losses=0,
    String rank,
    String tier,
    String queueType,
    this.leagueName,
  })  : rank = SummonerInfoConverts.rankTextConvert(rank),
        winRatio = SummonerInfoConverts.calculateWinRatio(wins, losses),
        queueType = SummonerInfoConverts.fixQueueType(queueType),
        tier=SummonerInfoConverts.fixTierName(tier);

  final String tier;
  final String rank;
  final int leaguePoints;
  final int wins;
  final int losses;
  final double winRatio;
  final String queueType;
  final String leagueName;

  static SummonerRanked createUnrankedSummoner(){
    return SummonerRanked(
      tier: 'Unranked',
    );
  }

  static SummonerRanked extractSoloRanked(List<dynamic> summonerRankedData,int soloRankedIndex,Map<String,dynamic> summonerLeagueData){
    return SummonerRanked(
      tier:summonerRankedData[soloRankedIndex]['tier'],
      leaguePoints:summonerRankedData[soloRankedIndex]['leaguePoints'],
      wins: summonerRankedData[soloRankedIndex]['wins'],
      losses: summonerRankedData[soloRankedIndex]['losses'],
      rank: summonerRankedData[soloRankedIndex]['rank'],
      queueType: summonerRankedData[soloRankedIndex]['queueType'],
      leagueName: summonerLeagueData['name'],
    );
  }

  static SummonerRanked extractFlexRanked(List<dynamic> summonerRankedData,int flexRankedIndex){
    return SummonerRanked(
      tier:summonerRankedData[flexRankedIndex]['tier'],
      leaguePoints:summonerRankedData[flexRankedIndex]['leaguePoints'],
      wins: summonerRankedData[flexRankedIndex]['wins'],
      losses: summonerRankedData[flexRankedIndex]['losses'],
      rank: summonerRankedData[flexRankedIndex]['rank'],
      queueType: summonerRankedData[flexRankedIndex]['queueType'],
    );
  }



}
