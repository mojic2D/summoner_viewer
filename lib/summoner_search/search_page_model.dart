import 'package:summoner_viewer/summoner_search/validators.dart';

class SearchPageModel with SummonerSearchTextValidator{
  SearchPageModel({
    this.searchText = '',
    this.dropdownValue = 'EUW',
    this.isLoading=false,
    this.submitted=false,
  });

  final bool submitted;
  final bool isLoading;
  final String searchText;
  final String dropdownValue;

  String get summonerNameErrorText{
    bool showErrorText=submitted &&!summonerNameValidator.isValid(searchText);
    return showErrorText?invalidSummonerNameErrorText:null;
  }

  bool isSearchTextEmpty(){
    if(searchText.isEmpty){
      return true;
    }
    return false;
  }

  SearchPageModel copyWith({
    String searchText,
    String dropdownValue,
    bool isLoading,
    bool submitted,
  }){
    return SearchPageModel(
      searchText: searchText??this.searchText,
      dropdownValue: dropdownValue??this.dropdownValue,
      isLoading: isLoading??this.isLoading,
      submitted: submitted??this.submitted,
    );
  }

}
