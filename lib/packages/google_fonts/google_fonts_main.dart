import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:package_examples/shared/appbar.dart';
import 'package:package_examples/shared/material_dropdown_view.dart';
import 'package:package_examples/shared/package_weblink_view.dart';
import 'package:package_examples/shared/setting_list.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontsMain extends StatefulWidget {
  @override
  _GoogleFontsMainState createState() => _GoogleFontsMainState();
}

class _GoogleFontsMainState extends State<GoogleFontsMain> {
  String _selectedCategory = 'SansSerif';
  int _displayCount = 10;
  final _myController = TextEditingController();
  HashMap<String, Category> _googleFontMap = getGoogleFontMap();
  late List<String> _filteredFontList;
  HashMap<Category, String> _categoryMap = HashMap.of({
    Category.SANSSERIF: 'SansSerif',
    Category.SERIF: 'Serif',
    Category.DISPLAY: 'Display',
    Category.HANDWRITING: 'Handwriting',
    Category.MONOSPACE: 'Monospace'
  });
  String _url = 'https://pub.dev/packages/google_fonts';
  String _googleFontVersion = '2.1.0';

  @override
  void initState() {
    _filteredFontList = _googleFontMap.keys.toList();
    _myController.text = 'The quick brown fox jumps over a lazy dog.';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Google Fonts'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            SettingList(
              children: <Widget>[
                MaterialDropdownView(
                    title: 'Select a font category',
                    subtitle: '',
                    value: _selectedCategory,
                    values: _categoryMap.values,
                    onChangedCallback: (newValue) {
                      onValueChanged(newValue as String);
                    },
                    negate: false),
                Align(
                  alignment: Alignment.centerLeft,
                  heightFactor: 1.5,
                  child: Text('Sentence',
                      style: Theme.of(context).textTheme.headline6),
                ),
                TextField(
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    hintText: 'Type something',
                    focusColor: Theme.of(context).primaryColor,
                    hoverColor: Theme.of(context).accentColor.withAlpha(50),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor)
                    ),
                  ),
                  controller: _myController,
                  onChanged: (value) => {
                    setState(() {}),
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                Column(
                  children: [
                    for (int i = 0;
                        i < min(_filteredFontList.length, _displayCount);
                        i++)
                      SizedBox(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(_filteredFontList[i]),
                              subtitle: Text(
                                _myController.text,
                                style: GoogleFonts.getFont(_filteredFontList[i])
                                    .copyWith(
                                        fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                if (_displayCount < _filteredFontList.length)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'load more',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black87),
                      ),
                      onPressed: () {
                        setState(() {
                          _displayCount += 6;
                        });
                      },
                    ),
                  )
              ],
            ),
            PackageWeblinkView(_googleFontVersion, _url),
          ],
        ),
      ),
    );
  }

  void onValueChanged(String newValue) {
    setState(() {
      _selectedCategory = newValue;
      _displayCount = 15;
      filterFontMap();
    });
  }

  void filterFontMap() {
    _filteredFontList = _googleFontMap.entries
        .where((element) => _categoryMap[element.value] == _selectedCategory)
        .map((e) => e.key)
        .toList();
  }

  static HashMap<String, Category> getGoogleFontMap() {
    return HashMap.of({
      'ABeeZee': Category.SANSSERIF,
      'Abel': Category.SANSSERIF,
      'Abhaya Libre': Category.SERIF,
      'Abril Fatface': Category.DISPLAY,
      'Aclonica': Category.SANSSERIF,
      'Acme': Category.SANSSERIF,
      'Actor': Category.SANSSERIF,
      'Adamina': Category.SERIF,
      'Advent Pro': Category.SANSSERIF,
      'Aguafina Script': Category.HANDWRITING,
      'Akronim': Category.DISPLAY,
      'Aladin': Category.HANDWRITING,
      'Alata': Category.SANSSERIF,
      'Alatsi': Category.SANSSERIF,
      'Aldrich': Category.SANSSERIF,
      'Alef': Category.SANSSERIF,
      'Alegreya': Category.SERIF,
      'Alegreya SC': Category.SERIF,
      'Alegreya Sans': Category.SANSSERIF,
      'Alegreya Sans SC': Category.SANSSERIF,
      'Aleo': Category.SERIF,
      'Alex Brush': Category.HANDWRITING,
      'Alfa Slab One': Category.DISPLAY,
      'Alice': Category.SERIF,
      'Alike': Category.SERIF,
      'Alike Angular': Category.SERIF,
      'Allan': Category.DISPLAY,
      'Allerta': Category.SANSSERIF,
      'Allerta Stencil': Category.SANSSERIF,
      'Allura': Category.HANDWRITING,
      'Almarai': Category.SANSSERIF,
      'Almendra': Category.SERIF,
      'Almendra Display': Category.DISPLAY,
      'Almendra SC': Category.SERIF,
      'Amarante': Category.DISPLAY,
      'Amaranth': Category.SANSSERIF,
      'Amatic SC': Category.HANDWRITING,
      'Amatica SC': Category.SANSSERIF,
      'Amethysta': Category.SERIF,
      'Amiko': Category.SANSSERIF,
      'Amiri': Category.SERIF,
      'Amita': Category.HANDWRITING,
      'Anaheim': Category.SANSSERIF,
      'Andada': Category.SERIF,
      'Andika': Category.SANSSERIF,
      'Andika New Basic': Category.SANSSERIF,
      'Annie Use Your Telescope': Category.HANDWRITING,
      'Anonymous Pro': Category.MONOSPACE,
      'Antic': Category.SANSSERIF,
      'Antic Didone': Category.SERIF,
      'Antic Slab': Category.SERIF,
      'Anton': Category.SANSSERIF,
      'Arapey': Category.SERIF,
      'Arbutus': Category.DISPLAY,
      'Arbutus Slab': Category.SANSSERIF,
      'Architects Daughter': Category.HANDWRITING,
      'Archivo': Category.SANSSERIF,
      'Archivo Black': Category.SANSSERIF,
      'Archivo Narrow': Category.SANSSERIF,
      'Aref Ruqaa': Category.SERIF,
      'Arima Madurai': Category.DISPLAY,
      'Arimo': Category.SANSSERIF,
      'Arizonia': Category.HANDWRITING,
      'Armata': Category.SANSSERIF,
      'Arsenal': Category.SANSSERIF,
      'Artifika': Category.SERIF,
      'Arvo': Category.SERIF,
      'Arya': Category.SANSSERIF,
      'Asap': Category.SANSSERIF,
      'Asar': Category.SERIF,
      'Asset': Category.DISPLAY,
      'Assistant': Category.SANSSERIF,
      'Astloch': Category.DISPLAY,
      'Asul': Category.SANSSERIF,
      'Athiti': Category.SANSSERIF,
      'Atma': Category.DISPLAY,
      'Atomic Age': Category.DISPLAY,
      'Aubrey': Category.DISPLAY,
      'Audiowide': Category.DISPLAY,
      'Autour One': Category.DISPLAY,
      'Average': Category.SERIF,
      'Average Sans': Category.SANSSERIF,
      'Averia Gruesa Libre': Category.DISPLAY,
      'Averia Libre': Category.DISPLAY,
      'Averia Sans Libre': Category.DISPLAY,
      'Averia Serif Libre': Category.DISPLAY,
      'B612': Category.SANSSERIF,
      'B612 Mono': Category.MONOSPACE,
      'Bad Script': Category.HANDWRITING,
      'Bahiana': Category.DISPLAY,
      'Bahianita': Category.DISPLAY,
      'Bai Jamjuree': Category.SANSSERIF,
      'Baloo': Category.SANSSERIF,
      'Baloo Bhai': Category.SANSSERIF,
      'Baloo Bhaijaan': Category.SANSSERIF,
      'Baloo Bhaina': Category.SANSSERIF,
      'Baloo Chettan': Category.SANSSERIF,
      'Baloo Da': Category.SANSSERIF,
      'Baloo Paaji': Category.SANSSERIF,
      'Baloo Tamma': Category.SANSSERIF,
      'Baloo Tammudu': Category.SANSSERIF,
      'Baloo Thambi': Category.SANSSERIF,
      'Balsamiq Sans': Category.DISPLAY,
      'Balthazar': Category.SERIF,
      'Bangers': Category.DISPLAY,
      'Barlow': Category.SANSSERIF,
      'Barlow Condensed': Category.SANSSERIF,
      'Barlow Semi Condensed': Category.SANSSERIF,
      'Barriecito': Category.DISPLAY,
      'Barrio': Category.DISPLAY,
      'Basic': Category.SANSSERIF,
      'Baskervville': Category.SERIF,
      'Baumans': Category.DISPLAY,
      'Be Vietnam': Category.SANSSERIF,
      'Bebas Neue': Category.DISPLAY,
      'Belgrano': Category.SERIF,
      'Bellefair': Category.SERIF,
      'Belleza': Category.SANSSERIF,
      'Bellota': Category.DISPLAY,
      'Bellota Text': Category.DISPLAY,
      'BenchNine': Category.SANSSERIF,
      'Bentham': Category.SERIF,
      'Berkshire Swash': Category.HANDWRITING,
      'Beth Ellen': Category.HANDWRITING,
      'Bevan': Category.DISPLAY,
      'Big Shoulders Display': Category.DISPLAY,
      'Big Shoulders Inline Display': Category.DISPLAY,
      'Big Shoulders Inline Text': Category.DISPLAY,
      'Big Shoulders Stencil Display': Category.DISPLAY,
      'Big Shoulders Stencil Text': Category.DISPLAY,
      'Big Shoulders Text': Category.DISPLAY,
      'Bigelow Rules': Category.DISPLAY,
      'Bigshot One': Category.DISPLAY,
      'Bilbo': Category.HANDWRITING,
      'Bilbo Swash Caps': Category.HANDWRITING,
      'BioRhyme': Category.SERIF,
      'BioRhyme Expanded': Category.SERIF,
      'Biryani': Category.SANSSERIF,
      'Bitter': Category.SERIF,
      'Black And White Picture': Category.SANSSERIF,
      'Black Han Sans': Category.SANSSERIF,
      'Black Ops One': Category.DISPLAY,
      'Blinker': Category.SANSSERIF,
      'Bonbon': Category.HANDWRITING,
      'Boogaloo': Category.DISPLAY,
      'Bowlby One': Category.DISPLAY,
      'Bowlby One SC': Category.DISPLAY,
      'Brawler': Category.SERIF,
      'Bree Serif': Category.SERIF,
      'Bubblegum Sans': Category.DISPLAY,
      'Bubbler One': Category.SANSSERIF,
      'Buda': Category.SANSSERIF,
      'Buenard': Category.SERIF,
      'Bungee': Category.DISPLAY,
      'Bungee Hairline': Category.DISPLAY,
      'Bungee Inline': Category.DISPLAY,
      'Bungee Outline': Category.DISPLAY,
      'Bungee Shade': Category.DISPLAY,
      'Butcherman': Category.DISPLAY,
      'Butterfly Kids': Category.HANDWRITING,
      'Cabin': Category.SANSSERIF,
      'Cabin Condensed': Category.SANSSERIF,
      'Cabin Sketch': Category.DISPLAY,
      'Caesar Dressing': Category.DISPLAY,
      'Cagliostro': Category.DISPLAY,
      'Cairo': Category.SANSSERIF,
      'Caladea': Category.SERIF,
      'Calistoga': Category.SANSSERIF,
      'Calligraffitti': Category.HANDWRITING,
      'Cambay': Category.SANSSERIF,
      'Cambo': Category.SERIF,
      'Candal': Category.SANSSERIF,
      'Cantarell': Category.SANSSERIF,
      'Cantata One': Category.SERIF,
      'Cantora One': Category.SANSSERIF,
      'Capriola': Category.SANSSERIF,
      'Cardo': Category.SERIF,
      'Carme': Category.SANSSERIF,
      'Carrois Gothic': Category.SANSSERIF,
      'Carrois Gothic SC': Category.SANSSERIF,
      'Carter One': Category.DISPLAY,
      'Castoro': Category.SERIF,
      'Catamaran': Category.SANSSERIF,
      'Caudex': Category.SERIF,
      'Caveat': Category.HANDWRITING,
      'Caveat Brush': Category.HANDWRITING,
      'Cedarville Cursive': Category.HANDWRITING,
      'Ceviche One': Category.DISPLAY,
      'Chakra Petch': Category.SANSSERIF,
      'Changa': Category.SANSSERIF,
      'Changa One': Category.DISPLAY,
      'Chango': Category.DISPLAY,
      'Charm': Category.HANDWRITING,
      'Charmonman': Category.HANDWRITING,
      'Chathura': Category.SANSSERIF,
      'Chau Philomene One': Category.SANSSERIF,
      'Chela One': Category.DISPLAY,
      'Chelsea Market': Category.DISPLAY,
      'Cherry Cream Soda': Category.DISPLAY,
      'Cherry Swash': Category.DISPLAY,
      'Chewy': Category.DISPLAY,
      'Chicle': Category.DISPLAY,
      'Chilanka': Category.HANDWRITING,
      'Chivo': Category.SANSSERIF,
      'Chonburi': Category.DISPLAY,
      'Cinzel': Category.SERIF,
      'Cinzel Decorative': Category.DISPLAY,
      'Clicker Script': Category.HANDWRITING,
      'Coda': Category.DISPLAY,
      'Coda Caption': Category.SANSSERIF,
      'Codystar': Category.SANSSERIF,
      'Coiny': Category.SANSSERIF,
      'Combo': Category.SANSSERIF,
      'Comfortaa': Category.SANSSERIF,
      'Comic Neue': Category.HANDWRITING,
      'Coming Soon': Category.HANDWRITING,
      'Commissioner': Category.SANSSERIF,
      'Concert One': Category.DISPLAY,
      'Condiment': Category.HANDWRITING,
      'Contrail One': Category.DISPLAY,
      'Convergence': Category.SANSSERIF,
      'Cookie': Category.HANDWRITING,
      'Copse': Category.SERIF,
      'Corben': Category.DISPLAY,
      'Cormorant': Category.SERIF,
      'Cormorant Garamond': Category.SERIF,
      'Cormorant Infant': Category.SERIF,
      'Cormorant SC': Category.SERIF,
      'Cormorant Unicase': Category.SERIF,
      'Cormorant Upright': Category.SERIF,
      'Courier Prime': Category.MONOSPACE,
      'Cousine': Category.MONOSPACE,
      'Cutive Mono': Category.MONOSPACE,
      'DM Mono': Category.MONOSPACE,
      'Fira Code': Category.MONOSPACE,
      'Fira Mono': Category.MONOSPACE,
      'IBM Plex Mono': Category.MONOSPACE,
      'Inconsolata': Category.MONOSPACE,
      'JetBrains Mono': Category.MONOSPACE,
      'Major Mono Display': Category.MONOSPACE,
      'Nanum Gothic Coding': Category.MONOSPACE,
      'Nova Mono': Category.MONOSPACE,
      'Overpass Mono': Category.MONOSPACE,
      'Oxygen Mono': Category.MONOSPACE,
      'PT Mono': Category.MONOSPACE,
      'Roboto Mono': Category.MONOSPACE,
      'Share Tech Mono': Category.MONOSPACE,
      'Source Code Pro': Category.MONOSPACE,
      'Space Mono': Category.MONOSPACE,
      'Syne Mono': Category.MONOSPACE,
      'Ubuntu Mono': Category.MONOSPACE,
      'VT323': Category.MONOSPACE,
      'Xanh Mono': Category.MONOSPACE,
    });
  }
}

enum Category { SANSSERIF, SERIF, DISPLAY, HANDWRITING, MONOSPACE }
