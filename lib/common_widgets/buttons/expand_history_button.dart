import 'package:flutter/material.dart';

class ExpandHistoryButton extends StatelessWidget {

  ExpandHistoryButton({@required this.onPressed,@required this.buttonText});

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: RaisedButton(
        child: Text(buttonText),
        color: Colors.blue[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }


}
