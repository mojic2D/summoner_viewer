import 'dart:convert';

import 'dart:io';

import 'package:flutter/services.dart';

class SummonerSingleMatchHistory {
  SummonerSingleMatchHistory({
    this.gameId,
    this.champion,
    this.queue,
    this.gameCreation,
    this.gameDuration,
    this.win,
    this.kills,
    this.deaths,
    this.assists,
    this.goldEarned,
    this.champLevel,
    this.creepScore,
  }):kda=_calculateKDA(kills,assists,deaths);

  final int gameId;
  final String champion;
  final int queue;
  final String gameCreation;
  final int gameDuration;
  final bool win;
  final int kills;
  final int deaths;
  final int assists;
  final String kda;
  final double goldEarned;
  final int champLevel;
  final int creepScore;


  static Future<SummonerSingleMatchHistory> createSingleMatchHistory(String summonerId,Map<String,dynamic> matchData) async{
    int gameId,queue,gameDuration,
        kills,deaths,assists,participantId,champLevel,
        creepScore;
    bool win;
    String champion,gameCreation;
    double goldEarned;

    gameId=matchData['gameId'];
    queue=matchData['queueId'];
    gameCreation=_convertGameCreation(matchData['gameCreation']);
    gameDuration=(matchData['gameDuration']/60).round();

    participantId=_extractParticipantId(summonerId, matchData['participantIdentities']);
    Map<String,dynamic> participant=matchData['participants'][participantId];
    champion= await _championNameFromId('${participant['championId']}');

    Map<String,dynamic> participantStats=participant['stats'];

    win=participantStats['win'];
    kills=participantStats['kills'];
    deaths=participantStats['deaths'];
    assists=participantStats['assists'];
    goldEarned=participantStats['goldEarned']/1000;
    champLevel=participantStats['champLevel'];
    creepScore=participantStats['totalMinionsKilled'];

    SummonerSingleMatchHistory hist=SummonerSingleMatchHistory(
      gameId: gameId,
      queue: queue,
      gameCreation: gameCreation,
      gameDuration: gameDuration,
      champion: champion,
      win: win,
      kills: kills,
      deaths: deaths,
      assists: assists,
      goldEarned: goldEarned,
      champLevel: champLevel,
      creepScore: creepScore,
    );
    return hist;
  }

  static Future<String> _championNameFromId(String championId)async{
    String json= await rootBundle.loadString('assets/lolChampions.json');
    Map<String,dynamic> championIdData=await jsonDecode(json);
    return championIdData[championId];
  }

  static String _convertGameCreation(int gameCreation){
      DateTime gameCreationDate=new DateTime.fromMillisecondsSinceEpoch(gameCreation);
      DateTime currentDate=new DateTime.now();
      int hoursDifference=currentDate.difference(gameCreationDate).inHours;
      if(hoursDifference<24){
        return '$hoursDifference hours ago';
      }
      int daysDifference=(hoursDifference/24).truncate().toInt();
      return '$daysDifference days ago';
  }

  static int _extractParticipantId(String summonerId,List<dynamic> participants){
    int currentParticipantId=0;

    for(int i=0;i<10;i++){
      if(participants[i]['player']['summonerId']==summonerId){
        currentParticipantId=participants[i]['participantId'];
        break;
      }
    }
    return currentParticipantId-1;
  }

  static String _calculateKDA(int kills,int assists,int deaths){
    double kda=(kills+assists)/deaths;
    return kda.toStringAsFixed(2);
  }





}
