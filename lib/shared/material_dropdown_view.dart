import 'package:flutter/material.dart';

class MaterialDropdownView extends StatelessWidget {
  final Function onChangedCallback;
  final String title, subtitle, value;
  final Iterable<String> values;

  MaterialDropdownView(
      {this.title = '',
      this.subtitle = '',
      required this.value,
      required this.values,
      required this.onChangedCallback});

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
              style: _themeData.textTheme.titleLarge!
            ),
          ),
        if (this.subtitle != '')
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              this.subtitle,
              style: _themeData.textTheme.titleMedium!,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 15.0, right: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.0),
                  border: Border.all()),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
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
        ),
      ],
    );
  }
}
