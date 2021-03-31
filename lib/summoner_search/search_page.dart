import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:summoner_viewer/common_widgets/alert_dialog/platform_alert_dialog.dart';
import 'package:summoner_viewer/common_widgets/buttons/form_submit_button.dart';
import 'package:summoner_viewer/rito_api/rito_api_calls.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';
import 'package:summoner_viewer/summoner_display_page/summoner_display_page.dart';
import 'package:summoner_viewer/summoner_search/search_page_bloc.dart';
import 'package:summoner_viewer/summoner_search/search_page_model.dart';

class SearchPage extends StatelessWidget {
  SearchPage({@required this.bloc});

  final SearchPageBloc bloc;

  static Widget create(BuildContext context) {
    final RitoApiCalls post = RitoApiCalls(apiKey:'RGAPI-50ec2981-8ad9-4fb3-8812-7c3678ace5e5');
    return Provider<SearchPageBloc>(
      create: (context) => SearchPageBloc(post: post),
      child: Consumer<SearchPageBloc>(
        builder: (context, bloc, _) => SearchPage(bloc: bloc),
      ),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  Future<void> _submit(BuildContext context)async{
    try {
      Summoner summoner = await bloc.searchBySummonerName();
      if(summoner!=null){
        Navigator.of(context).push(MaterialPageRoute<void>(
          fullscreenDialog: true,
          builder: (context) => SummonerDisplayPage(summoner: summoner),
        ));
      }
    } catch (e) {
      print(e);
      PlatformAlertDialog(
        title: 'Search failed',
        content: 'Search failed',
        defaultActionText: 'Okay',
      ).show(context);
    }
  }

  List<Widget> _buildChildren(SearchPageModel model, BuildContext context) {
    return [
      SizedBox(height: 25.0),
      _buildSearchTextField(model),
      SizedBox(height: 8.0),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRegionDropdownButton(model),
          FormSubmitButton(
            text: 'SEARCH',
            onPressed: model.isLoading || model.isSearchTextEmpty()
                ? null
                : () => _submit(context),
          ),
        ],
      ),
    ];
  }

  DropdownButton<String> _buildRegionDropdownButton(SearchPageModel model) {
    return DropdownButton<String>(
      value: model.dropdownValue,
      icon: Icon(Icons.arrow_downward,color: Colors.black,),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w900),
      underline: Container(
        height: 3,
        color: Colors.blue,
      ),
      onChanged: model.isLoading
          ? null
          : (newValue) => bloc.updateDropdownValue(newValue),
      items: <String>[
        'EUW',
        'EUNE',
        'NA',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  TextField _buildSearchTextField(SearchPageModel model) {
    return TextField(
      //controller:_searchTextController,
      decoration: InputDecoration(
        labelText: 'Search...',
        hintText: 'Summoner name...',
        errorText: model.summonerNameErrorText,
        enabled: model.isLoading == false,
      ),
      onChanged: bloc.updateSearchText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search by Summoner Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<SearchPageModel>(
          stream: bloc.modelStream,
          initialData: SearchPageModel(),
          builder: (context, snapshot) {
            final SearchPageModel model = snapshot.data;
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _buildChildren(model, context),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
