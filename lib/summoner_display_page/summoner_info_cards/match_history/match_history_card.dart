import 'package:flutter/material.dart';
import 'package:summoner_viewer/common_widgets/buttons/expand_history_button.dart';
import 'package:summoner_viewer/rito_api/summoner/summoner.dart';
import 'package:summoner_viewer/summoner_display_page/summoner_info_cards/match_history/single_match_history_card.dart';


class MatchHistoryCard extends StatefulWidget {
  MatchHistoryCard({@required this.summoner});

  final Summoner summoner;

  @override
  _MatchHistoryCardState createState() => _MatchHistoryCardState();
}

class _MatchHistoryCardState extends State<MatchHistoryCard>
    with SingleTickerProviderStateMixin {
  AnimationController expandController;
  Animation<double> animation;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void prepareAnimations() {
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  String _historyButtonText(){
    if(expanded){
      return 'Hide match history';
    }
    return 'Show match history';
  }

  void _showHideHistory(){
    setState(() {
      expanded=expanded?false:true;
    });
    expanded?expandController.forward():expandController.reverse();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: new BorderSide(
          color: Colors.black,
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            ExpandHistoryButton(
              onPressed: _showHideHistory,
              buttonText: _historyButtonText(),
            ),
            SizeTransition(
              axisAlignment: 1.0,
              sizeFactor: animation,
              child: Column(
                children: [
                  SingleMatchHistoryCard(
                      matchHistoryData: widget.summoner.matchHistory[0]),
                  SingleMatchHistoryCard(
                      matchHistoryData: widget.summoner.matchHistory[1]),
                  SingleMatchHistoryCard(
                      matchHistoryData: widget.summoner.matchHistory[2]),
                  SingleMatchHistoryCard(
                      matchHistoryData: widget.summoner.matchHistory[3]),
                  SingleMatchHistoryCard(
                      matchHistoryData: widget.summoner.matchHistory[4]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
