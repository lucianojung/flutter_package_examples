import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_custom_carousel/flutter_custom_carousel.dart';

import '../../shared/appbar.dart';
import '../../shared/package_weblink_view.dart';
import '../../shared/setting_list.dart';

class CustomCarouselMain extends StatefulWidget {
  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarouselMain> {
  int? _Index = 0;
  double _itemCountBefore = 1;
  double _itemCountAfter = 1;

  //double _scrollSpeed = 1.5;
  bool _loop = true;
  RangeValues _flipH = RangeValues(-0.0, 0.0);
  RangeValues _flipV = RangeValues(-0.2, 0.2);
  RangeValues _slideX = RangeValues(-0, 0);
  RangeValues _slideY = RangeValues(-2, 2);
  double _blur = 8;
  final ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Custom Carousel'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _buildCarousel(),
      ),
    );
  }

  @override
  void dispose() {
    _expandableController.dispose();
    super.dispose();
  }

  Widget _buildCarousel() {
    List<Widget> items = [];
    for (int i = 0; i < 100; i++) {
      items.add(_ExampleCard(
        index: i,
        selected: i == _Index,
        key: ValueKey(i),
      ));
    }

    // See `card_deck_view.dart` for a fully commented example of using
    // Animate with CustomCarousel.
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Flexible(
          child: CustomCarousel(
            alignment: Alignment.center,
            itemCountBefore: _itemCountBefore.toInt(),
            itemCountAfter: _itemCountAfter.toInt(),
            loop: _loop,
            effectsBuilder: CustomCarousel.effectsBuilderFromAnimate(
              effects: EffectList()
                  .blurXY(delay: 0.ms, duration: 100.ms, begin: _blur)
                  .blurXY(delay: 100.ms, end: _blur)
                  .slideY(
                      delay: 0.ms,
                      duration: 200.ms,
                      begin: _slideY.start,
                      end: _slideY.end)
                  .slideX(
                      delay: 0.ms,
                      duration: 200.ms,
                      begin: _slideX.start,
                      end: _slideX.end)
                  .flipH(begin: _flipH.start, end: _flipH.end)
                  .flipV(begin: _flipV.start, end: _flipV.end),
            ),
            onSettledItemChanged: (i) => setState(() => _Index = i),
            children: items,
          ),
        ),
        ExpandableNotifier(
          controller: _expandableController,
          child: Expandable(
            collapsed: Container(
              width: 999,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                border: const Border(
                  top: BorderSide(color: Colors.white12, width: 2),
                ),
              ),
              child: ExpandableButton(child: Icon(Icons.keyboard_arrow_up, color: Colors.black,)),
            ),
            expanded: Container(
              height: 444,
              padding: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                border: const Border(
                  top: BorderSide(color: Colors.white12, width: 2),
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: SettingList(children: [
                ExpandableButton(child: Icon(Icons.keyboard_arrow_down, color: Colors.black,)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Item count before/ after',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Slider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _itemCountBefore,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: '$_itemCountBefore',
                    onChanged: (newRange) {
                      setState(() {
                        _itemCountBefore = newRange;
                      });
                    }),
                Slider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _itemCountAfter,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: '$_itemCountAfter',
                    onChanged: (newRange) {
                      setState(() {
                        _itemCountAfter = newRange;
                      });
                    }),
                CheckboxListTile(
                  title: Text("Loop"),
                  value: _loop,
                  onChanged: (newValue) {
                    setState(() {
                      _loop = newValue!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Flip horizontal/ vertical',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                RangeSlider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    values: _flipH,
                    min: -1,
                    max: 1,
                    divisions: 20,
                    labels: RangeLabels(
                      _flipH.start.toStringAsFixed(1).toString(),
                      _flipH.end.toStringAsFixed(1).toString(),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _flipH = newRange;
                      });
                    }),
                RangeSlider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    values: _flipV,
                    min: -1,
                    max: 1,
                    divisions: 20,
                    labels: RangeLabels(
                      _flipV.start.toStringAsFixed(1).toString(),
                      _flipV.end.toStringAsFixed(1).toString(),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _flipV = newRange;
                      });
                    }),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Blur',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Slider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _blur,
                    min: 0,
                    max: 42,
                    divisions: 42,
                    label: '${_blur.toInt()}',
                    onChanged: (newRange) {
                      setState(() {
                        _blur = newRange;
                      });
                    }),
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Slide X/ Y',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                RangeSlider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    values: _slideX,
                    min: -1,
                    max: 1,
                    divisions: 20,
                    labels: RangeLabels(
                      _slideX.start.toStringAsFixed(1).toString(),
                      _slideX.end.toStringAsFixed(1).toString(),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _slideX = newRange;
                      });
                    }),
                RangeSlider(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    values: _slideY,
                    min: -5,
                    max: 5,
                    divisions: 50,
                    labels: RangeLabels(
                      _slideY.start.toStringAsFixed(1).toString(),
                      _slideY.end.toStringAsFixed(1).toString(),
                    ),
                    onChanged: (newRange) {
                      setState(() {
                        _slideY = newRange;
                      });
                    }),
                PackageWeblinkView('flutter_custom_carousel 0.1.0+1',
                    'https://pub.dev/packages/flutter_custom_carousel'),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExampleCard extends StatelessWidget {
  const _ExampleCard({
    Key? key,
    required this.index,
    this.selected = false,
  }) : super(key: key);

  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    Widget card = AspectRatio(
      aspectRatio: 2,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              Color(((index - 42) / 100 * 0xFFFFFF).toInt()).withOpacity(1.0),
          image: DecorationImage(
            image: AssetImage('assets/flutter_packages_logo_grey.png'),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(8),
          border: const Border(
            top: BorderSide(color: Colors.white12, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Example Card ${index}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            if (selected)
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: const Text(
                    'Click me!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .moveX(begin: -6, curve: Curves.easeOut),
              )
          ],
        ),
      ),
    );
    return card;
  }
}
