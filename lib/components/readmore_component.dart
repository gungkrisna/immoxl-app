import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/translations.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final Color expandingTextColor;
  ReadMoreText(this.text, {this.expandingTextColor});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText>
    with TickerProviderStateMixin<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 100),
          alignment: Alignment.topCenter,
          curve: Curves.easeInOutCubic,
          child: ConstrainedBox(
            constraints:
                isExpanded ? BoxConstraints() : BoxConstraints(maxHeight: 55.0),
            child: Text(
              widget.text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14,
                fontFamily: 'PTSans',
              ),
              softWrap: true,
              overflow: TextOverflow.clip,
            ),
          )),
      SizedBox(height: 5),
      Row(
        children: <Widget>[
          !isExpanded
              ? GestureDetector(
                  onTap: () => setState(() => isExpanded = true),
                  child: Text(Translations.of(context).text('property', 'MORE'),
                      style: TextStyle(
                        color: IMMOXLTheme.lightblue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'PTSans',
                      )),
                )
              : SizedBox(),
        ],
      )
    ]);
  }
}
