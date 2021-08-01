import 'package:flutter/material.dart';

class MaterialDropdownView extends StatelessWidget {
  final Function onChangedCallback;
  String title, subtitle, value;
  Iterable<String> values = [];
  bool negate;

  MaterialDropdownView(
      {required this.title,
      required this.subtitle,
      required this.value,
      required this.values,
      required this.onChangedCallback,
      required this.negate}) {
    this.title = title != null ? title : '';
    this.subtitle = subtitle != null ? subtitle : '';
    this.negate = negate != null ? negate : false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        if (this.title != '')
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              this.title,
              style: _themeData.textTheme.headline6!
            ),
          ),
        if (this.subtitle != '')
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              this.subtitle,
              style: _themeData.textTheme.subtitle1!,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              SizedBox(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: this.value,
                          items: this
                              .values
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            this.onChangedCallback(newValue);
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
