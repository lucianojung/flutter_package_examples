import 'package:flutter/material.dart';

class MaterialDropdownView extends StatelessWidget {
  final Function onChangedCallback;
  String title, subtitle, value;
  List<String> values = [];
  bool negate;

  MaterialDropdownView({required this.title, required this.subtitle, required this.value, required this.values, required this.onChangedCallback, required this.negate}) {
    this.title = title != null ? title : '';
    this.subtitle = subtitle != null ? subtitle : '';
    this.negate = negate != null ? negate : false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            this.title,
            style: _themeData.textTheme.headline5!.copyWith(color: negate ? Colors.white : Colors.black),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: this.subtitle != '' ? Text(
            this.subtitle,
            style: _themeData.textTheme.subtitle1!.copyWith(color: negate ? Colors.white : Colors.black),
          ) : SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.white,
                border: Border.all()),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: this.value,
                  items: this.values.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: _themeData.textTheme.subtitle1,
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    this.onChangedCallback(newValue);
                  }),
            ),
          ),
        ),
      ],
    );
  }
}