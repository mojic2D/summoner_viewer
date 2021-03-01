class SummonerInfoConverts{
  static String rankTextConvert(String rank){
    switch(rank){
      case 'I': return '1';
      case 'II': return '2';
      case 'III': return '3';
      case 'IV': return '4';
      default: return 'Unranked';
    }
  }
  static double calculateWinRatio(int wins, int losses){
    if(losses==0&&wins==0){
      return 0.0;
    }
    return double.parse((wins/(losses+wins)*100).toStringAsFixed(2));
  }

  static String fixQueueType(String queueType){
    switch(queueType){
      case 'RANKED_SOLO_5x5':return 'Ranked Solo';
      case 'RANKED_FLEX_SR':return 'Flex 5:5 Rank';
      default: return 'Uranked';
    }
  }

  static String fixTierName(String tier) {
    switch(tier){
      case 'IRON':return 'Iron';
      case 'BRONZE':return 'Bronze';
      case 'SILVER':return 'Silver';
      case 'GOLD':return 'Gold';
      case 'PLATINUM':return 'Platinum';
      case 'DIAMOND':return 'Diamond';
      case 'MASTER':return 'Master';
      case 'GRANDMASTER':return 'Grandmaster';
      case 'CHALLENGER':return 'Challenjour';
      default: return 'Unranked';
    }
  }

}