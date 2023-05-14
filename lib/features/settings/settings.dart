import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_locale.dart';
import '../items_overview/presentation/widgets/logo_bar.dart';

final _scrollController = ScrollController();

class SettingsPage extends StatelessWidget {
  final _cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 12);
  final _sliderTextStyle = TextStyle(fontSize: 10, color: Colors.black54);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (
          BuildContext context,
          bool innerBoxIsScrolled,
        ) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              titleSpacing: 0,
              toolbarHeight: 70,
              backgroundColor: Theme.of(context).primaryColor,
              title: LogoBar(
                onSettingsPressed: () {
                  Navigator.of(context).pop();
                },
                actionAsset: 'assets/icons/close.svg',
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(children: [
              Card(
                child: Row(
                  children: [
                    Padding(
                      padding: _cardPadding,
                      child: Text(
                        AppLocale.of(context).settings,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(children: [
                  Text(
                    AppLocale.of(context).fontSize,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ]),
              ),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 2, right: 10, top: 10),
                  child: Stack(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          color: Color.fromARGB(25, 60, 60, 60),
                        ),
                        width: 102,
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(children: [
                            Text('0.5x', style: _sliderTextStyle),
                            Padding(
                              padding: EdgeInsets.only(left: 6, right: 8),
                              child: Text('|', style: _sliderTextStyle),
                            ),
                            Text('1x', style: _sliderTextStyle),
                            Padding(
                              padding: EdgeInsets.only(left: 6, right: 8),
                              child: Text('|', style: _sliderTextStyle),
                            ),
                            Text('2x', style: _sliderTextStyle),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Slider(
                        value: 3,
                        onChanged: (v) => {
                          //todo
                        },
                        min: 1,
                        max: 3,
                        divisions: 2,
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        thumbColor: Colors.white,
                        activeColor: Colors.transparent,
                        inactiveColor: Colors.transparent,
                      ),
                    ),
                  ]),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(children: [
                  Text(
                    AppLocale.of(context).darkTheme,
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(children: [
                  CupertinoSwitch(
                    onChanged: (b) => {
                      // todo
                    },
                    value: false,
                  ),
                ]),
              ),
              Card(
                child: Padding(
                  padding: _cardPadding,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 80,
                        child: Text(
                          AppLocale.of(context).contact,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child:
                            SvgPicture.asset('assets/icons/arrow-forward.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: _cardPadding,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 80,
                        child: Text(
                          AppLocale.of(context).aboutTeam,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child:
                            SvgPicture.asset('assets/icons/arrow-forward.svg'),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
