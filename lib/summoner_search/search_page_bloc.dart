import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:summoner_viewer/rito_api/rito_api_calls.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';
import 'package:summoner_viewer/summoner_search/search_page_model.dart';

class SearchPageBloc{

  SearchPageBloc({@required this.post});

  final RitoApiCalls post;

  final StreamController<SearchPageModel> _modelController=StreamController<SearchPageModel>();
  Stream<SearchPageModel> get modelStream=>_modelController.stream;
  SearchPageModel _model=SearchPageModel();

  void dispose(){
    _modelController.close();
  }

  Future<Summoner> searchBySummonerName() async{
    updateWith(submitted:true,isLoading: true);
    try {
      Summoner summoner=await post.getSummoner(_model.searchText,regionTextFix(_model.dropdownValue));
      print('SummonerID:${summoner.id}');
      return summoner;
    }catch(e){
      rethrow;
    }finally{
      updateWith(isLoading:false);
    }
  }

  String regionTextFix(String s){
    switch(s){
      case 'EUW':
        return 'EUW1';
      case 'EUNE':
        return 'EUN1';
      case 'NA':
        return 'NA1';
    }
  }

  void updateSearchText(String searchText)=>updateWith(searchText: searchText);
  void updateDropdownValue(String dropdownValue)=>updateWith(dropdownValue: dropdownValue);

  void updateWith({
    String searchText,
    String dropdownValue,
    bool isLoading,
    bool submitted,
  }){
    _model=_model.copyWith(
      searchText: searchText,
      dropdownValue: dropdownValue,
      isLoading: isLoading,
      submitted: submitted,
    );
    _modelController.add(_model);
  }
}