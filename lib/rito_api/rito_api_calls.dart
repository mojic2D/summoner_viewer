import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:summoner_viewer/rito_api/challenger_player.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner_ranked.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner_single_match_history.dart';

class RitoApiCalls {
  RitoApiCalls({@required this.apiKey});
  final String apiKey;

  Future<List<ChallengerPlayer>> getChallengerLadder()async{
    Response response= await getChallengerData();
    List<dynamic> challengerList=jsonDecode(response.body)['entries'];

    List<ChallengerPlayer> challengerListOrdered=new List<ChallengerPlayer>();

    for(var i=0;i<challengerList.length;i++){
      Map<String,dynamic> challengerPlayerInfo=challengerList[i];
      challengerListOrdered.add(
          ChallengerPlayer(summonerName: challengerPlayerInfo['summonerName'],
          leaguePoints: challengerPlayerInfo['leaguePoints'],
          wins: challengerPlayerInfo['wins'],
          losses: challengerPlayerInfo['losses'])
      );
      i++;
    }
    challengerListOrdered.sort((a,b)=>b.leaguePoints.compareTo(a.leaguePoints));
    return challengerListOrdered;
  }

  Future<Summoner> getSummoner(String summonerName, String region) async {

    Response baseSummonerInfoResponse =
        await getBaseSummonerData(summonerName, region);
    Map<String, dynamic> summonerData =
        jsonDecode(baseSummonerInfoResponse.body);

    Response matchHistoryInfoResponse =
        await getMatchHistory(summonerData['accountId']);
    Map<String, dynamic> matchHistoryBruteData =
        jsonDecode(matchHistoryInfoResponse.body);
    List<dynamic> matchHistoryData = matchHistoryBruteData['matches'];

    List<SummonerSingleMatchHistory> matchHistory =
        await createMatchHistoryList(
            summonerData['id'], extractMatchIds(matchHistoryData));

    Response rankedSummonerInfoResponse =
        await getRankedData(summonerData['id']);
    List<dynamic> summonerRankedData =
        jsonDecode(rankedSummonerInfoResponse.body);

    int soloRankedIndex = -1;
    int flexRankedIndex = -1;
    if (summonerRankedData.isEmpty) {
      return Summoner.createSummoner(
        summonerData,
        SummonerRanked.createUnrankedSummoner(),
        SummonerRanked.createUnrankedSummoner(),
        matchHistory,
      );
    } else {
      soloRankedIndex = _dataContainsSoloRanked(summonerRankedData);
      flexRankedIndex = _dataContainsFlexRanked(summonerRankedData);
      if (soloRankedIndex != -1) {
        Response response2 = await getLeagueName(
            summonerRankedData[soloRankedIndex]['leagueId']);
        Map<String, dynamic> summonerLeagueData = jsonDecode(response2.body);
        if (flexRankedIndex != -1) {
          return Summoner.createSummoner(
            summonerData,
            SummonerRanked.extractSoloRanked(
                summonerRankedData, soloRankedIndex, summonerLeagueData),
            SummonerRanked.extractFlexRanked(
                summonerRankedData, flexRankedIndex),
            matchHistory,
          );
        }
        return Summoner.createSummoner(
          summonerData,
          SummonerRanked.extractSoloRanked(
              summonerRankedData, soloRankedIndex, summonerLeagueData),
          SummonerRanked.createUnrankedSummoner(),
          matchHistory,
        );
      }
    }
    return Summoner.createSummoner(
      summonerData,
      SummonerRanked.createUnrankedSummoner(),
      SummonerRanked.extractFlexRanked(summonerRankedData, flexRankedIndex),
      matchHistory,
    );
  }

  Future<Response> getChallengerData()async{
    var url =
        'https://euw1.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/RANKED_SOLO_5x5?api_key=$apiKey';
    return await http.get(url);
  }

  Future<Response> getBaseSummonerData(String summonerName,String region) async{
    var url =
        'https://$region.api.riotgames.com/lol/summoner/v4/summoners/by-name/$summonerName?api_key=$apiKey';
    return await http.get(url);
  }

  Future<Response> getRankedData(String userId) async {
    var url =
        'https://euw1.api.riotgames.com/lol/league/v4/entries/by-summoner/$userId?api_key=$apiKey';
    return await http.get(url);
  }

  Future<Response> getLeagueName(String name) async {
    var url =
        'https://euw1.api.riotgames.com/lol/league/v4/leagues/$name?api_key=$apiKey';
    return await http.get(url);
  }

  Future<Response> getMatchHistory(String accountId) async {
    var url =
        'https://euw1.api.riotgames.com/lol/match/v4/matchlists/by-account/$accountId?endIndex=10&api_key=$apiKey';
    return await http.get(url);
  }

  Future<Response> getMatchData(int matchId) async {
    var url =
        'https://euw1.api.riotgames.com/lol/match/v4/matches/$matchId?api_key=$apiKey';
    return await http.get(url);
  }

  List<int> extractMatchIds(List<dynamic> matchHistoryData) {
    List<int> matchIds = new List<int>();
    for (var i = 0; i < 5; i++) {
      matchIds.add(matchHistoryData[i]['gameId']);
    }
    return matchIds;
  }

  Future<List<SummonerSingleMatchHistory>> createMatchHistoryList(
      String summonerId, List<int> matchIds) async {
    List<SummonerSingleMatchHistory> matchHistoryList =
        List<SummonerSingleMatchHistory>();
    Response matchDataResponse;
    Map<String, dynamic> matchData;
    for (var i = 0; i < 5; i++) {
      matchDataResponse = await getMatchData(matchIds[i]);
      matchData = jsonDecode(matchDataResponse.body);
      matchHistoryList.add(
          await SummonerSingleMatchHistory.createSingleMatchHistory(
              summonerId, matchData));
    }
    return matchHistoryList;
  }

  int _dataContainsSoloRanked(List<dynamic> data) {
    if (data[0]['queueType'] == 'RANKED_SOLO_5x5') {
      return 0;
    }
    if (data.length == 2) {
      if (data[1]['queueType'] == 'RANKED_SOLO_5x5') {
        return 1;
      }
    }
    return -1;
  }

  int _dataContainsFlexRanked(List<dynamic> data) {
    if (data[0]['queueType'] == 'RANKED_FLEX_SR') {
      return 0;
    }
    if (data.length == 2) {
      if (data[1]['queueType'] == 'RANKED_FLEX_SR') {
        return 1;
      }
    }
    return -1;
  }


}
