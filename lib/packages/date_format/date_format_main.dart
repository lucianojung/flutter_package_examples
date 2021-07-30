import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
import 'package:package_examples/shared/package_weblink_view.dart';

class DateFormatMain extends StatefulWidget {
  @override
  _DateFormatMainState createState() => _DateFormatMainState();
}

class _DateFormatMainState extends State<DateFormatMain> {
  String _dateFormat = 'DD, dd.MM.yyyy';
  String _formattedText = '';
  late Timer timer;
  DateLocale _dateLocale = EnglishDateLocale();
  String _dateLocaleString = 'EnglishDateLocale';
  List<String> _dateLocaleList = ['EnglishDateLocale', 'ItalianDateLocale ', 'SpanishDateLocale', 'PortugueseDateLocale', 'TurkishDateLocale', 'VietnameseDateLocale'];

  List<String> _dateFormatList = [
    'DD, dd.MM.yyyy',
    'D, d.M.yyyy',
    'd.m.yyyy',
    'mm/dd/yyyy',
    'dd.mm.yyyy, HH:nn:ss',
    'hh:nn:ss am',
    'HH:nn:ss:SSS:uuu',
    'HH:nn:ss Z',
    'custom'
  ];
  final _myController = TextEditingController(text: 'DD, dd.MM.yyyy');

  @override
  void initState() {
    _formattedText = _formatDate(_dateFormat, DateTime.now());
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) => _getTime());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Date Format'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
              child: MaterialDropdownView(
                title: 'Date Format',
                subtitle: 'Select a format to display below',
                onChangedCallback: (newValue) {
                  _onDateFormatChanged(newValue);
                },
                value: _dateFormat,
                values: _dateFormatList,
                negate: false,
              ),
            ),
            if (_dateFormat == 'custom')
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextField(
                    controller: _myController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                        hintText: 'Enter a DateFormat String'),
                    onChanged: (value) => {
                      setState(() {
                        _onDateFormatChanged(_dateFormat);
                      }),
                    },
                  ),
                ),
              ),
            Padding(
              padding:
              const EdgeInsets.only(bottom: 0, left: 16.0, right: 16.0),
              child: MaterialDropdownView(
                title: '',
                subtitle: 'Select a locale to change the date format language',
                onChangedCallback: (newValue) {
                  _onDateLocaleChanged(newValue);
                },
                value: _dateLocaleString,
                values: _dateLocaleList,
                negate: false,
              ),
            ),
            ExpandableNotifier(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("CheatSheet",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(fontSize: 18))),
                      collapsed: SizedBox(),
                      expanded: cheatSheetContent(),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: const ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Text(
                _formattedText,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            PackageWeblinkView('date_format 2.0.2',
                'https://pub.dev/packages/date_format'),
          ],
        ),
      ),
    );
  }

  void _onDateFormatChanged(String newValue) {
    setState(() {
      _dateFormat = newValue;
      _formattedText = _formatDate(_dateFormat, DateTime.now());
    });
  }

  void _onDateLocaleChanged(String newValue) {
    setState(() {
      _dateLocaleString = newValue;
      _dateLocale = getDateLocaleFromString(_dateLocaleString);
      _formattedText = _formatDate(_dateFormat, DateTime.now());
    });
  }

  void _getTime() {
    setState(() {
      _formattedText = _formatDate(_dateFormat, DateTime.now());
    });
  }

  String _formatDate(String dateFormat, DateTime datetime) {
    switch (dateFormat) {
      case 'DD, dd.MM.yyyy':
        return formatDate(datetime, [DD, ', ', dd, '.', MM, '.', yyyy], locale: _dateLocale);
      case 'D, d.M.yyyy':
        return formatDate(datetime, [D, ', ', d, '.', M, '.', yyyy], locale: _dateLocale);
      case 'd.m.yyyy':
        return formatDate(datetime, [d, '.', m, '.', yyyy], locale: _dateLocale);
      case 'mm/dd/yyyy':
        return formatDate(datetime, [mm, '/', dd, '/', yyyy], locale: _dateLocale);
      case 'dd.mm.yyyy, HH:nn:ss':
        return formatDate(datetime, [dd, '.', mm, '.', yyyy, ', ', HH, ':', nn, ':', ss], locale: _dateLocale);
      case 'hh:nn:ss am':
        return formatDate(datetime, [hh, ':', nn, ':', ss, ' ', am], locale: _dateLocale);
      case 'HH:nn:ss:SSS:uuu':
        return formatDate(datetime, [HH, ':', nn, ':', ss, ':', SSS, ':', uuu], locale: _dateLocale);
      case 'HH:nn:ss Z':
        return formatDate(datetime, [HH, ':', nn, ':', ss, ' ', Z], locale: _dateLocale);
      default:
        var format = stringToDateFormatArray(_myController.text);
        return formatDate(datetime, format, locale: _dateLocale);
    }
  }

  List<String> stringToDateFormatArray(String customDateFormat) {
    var charArray = customDateFormat.split('');
    var format = <String>[charArray[0]];
    for (int i = 1; i < charArray.length; i++) {
      var value = charArray[i];
      if (value == charArray[i - 1] || charArray[i - 1] == '\\')
        format[format.length - 1] = format.last + value;
      else
        format.add(value);
    }
    return format;
  }

  cheatSheetContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'yy or yyyy  ->  Year\n',
              ),
              TextSpan(
                text: 'm or mm   ->  Number of Month\n',
              ),
              TextSpan(
                text: 'M or MM   ->  String of Month\n',
              ),
              TextSpan(
                text: 'dd or d       ->  Day\n',
              ),
              TextSpan(
                text: 'w                 ->  week in month\n',
              ),
              TextSpan(
                text: 'W or WW    ->  week in year\n',
              ),
              TextSpan(
                text: 'D or DD       ->  weekday\n',
              ),
              TextSpan(
                text: 'h or hh        ->  hour (0 - 11)\n',
              ),
              TextSpan(
                text: 'H or HH      ->  hour (0 - 23)\n',
              ),
              TextSpan(
                text: 'n or nn        ->  minutes\n',
              ),
              TextSpan(
                text: 's or ss         ->  seconds\n',
              ),
              TextSpan(
                text: 'S or SSS      ->  milliseconds\n',
              ),
              TextSpan(
                text: 'u or uuu       ->  microseconds-> \n',
              ),
              TextSpan(
                text: 'am                ->  AM or PM\n',
              ),
              TextSpan(
                text: 'z or Z            ->  timezone\n',
              ),
              TextSpan(
                text: '\\                   ->  Escape delimiter',
              ),
            ]),
          ),
        ),
      ],
    );
  }

  DateLocale getDateLocaleFromString(String dateLocaleString) {
    switch (dateLocaleString) {
      case 'EnglishDateLocale':
        return EnglishDateLocale();
      case 'ItalianDateLocale ':
        return ItalianDateLocale();
      case 'SpanishDateLocale':
        return SpanishDateLocale();
      case 'PortugueseDateLocale':
        return PortugueseDateLocale();
      case 'TurkishDateLocale':
        return TurkishDateLocale();
      case 'VietnameseDateLocale':
        return VietnameseDateLocale();
      default:
        return EnglishDateLocale();
    }
  }
}
