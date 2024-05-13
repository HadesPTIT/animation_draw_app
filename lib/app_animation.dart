// ignore_for_file: avoid_print

import 'package:animation_draw_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AppAnimation extends StatefulWidget {
  const AppAnimation({super.key});

  @override
  State<AppAnimation> createState() => _AppAnimationState();
}

class _AppAnimationState extends State<AppAnimation> {
  // Init current percentage
  double currentPercentFactor = 0.2;

  bool upPoint = false;
  bool keepBase = false;

  // Offset of target widget
  final _targetHeartKey = GlobalKey();

  // Target offset first heart widget
  final _baseFirstHeartKey = GlobalKey();
  var _targetFirstOffset = Offset.zero;

  // Target offset second heart widget
  final _baseSecondHeartKey = GlobalKey();
  var _targetSecondOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                _buildBackground(),
                _buildBottomCTAs(),
              ],
            ),
          ),
          Positioned.fill(
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  children: [
                    _buildText(),
                    _buildHeart(),
                    _buildNextMinestone(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Expanded(
      child: Opacity(
        opacity: 0.7,
        child: Image.asset(
          Assets.images.imIntro.path,
        ),
      ).animate().fade(duration: 1000.milliseconds),
    );
  }

  Widget _buildBottomCTAs() {
    return Expanded(
      child: Container(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 170,
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Text(
                    'Redesign',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: 170,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.orange[600],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ).animate(delay: 7.seconds).fadeIn(duration: 1.seconds),
    );
  }

  Widget _buildNextMinestone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 30),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[700],
        ),
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'NEXT MINESTONE',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                          Container(
                            key: _targetHeartKey,
                            child: _heart(width: 15, height: 15)
                                .animate(delay: 7.seconds)
                                .scaleXY(end: 2)
                                .then()
                                .scaleXY(end: 0.5),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${(currentPercentFactor * 10).toInt()}/10',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ).animate(),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearPercentIndicator(
                        lineHeight: 11.0,
                        percent: currentPercentFactor,
                        animation: true,
                        animationDuration: 1000,
                        animateFromLastPercent: true,
                        padding: EdgeInsets.zero,
                        barRadius: const Radius.circular(8),
                        backgroundColor: Colors.white,
                        progressColor: Colors.red,
                      ).animate(delay: 6.seconds).then().callback(
                        callback: (value) {
                          setState(() {
                            currentPercentFactor = 0.3;
                            Future.delayed(300.milliseconds).then((value) {
                              setState(() {
                                currentPercentFactor = 0.4;
                              });
                            });
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    Assets.images.imMoney.path,
                    width: 55,
                    height: 55,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(delay: 1150.milliseconds)
        .fade(duration: 200.milliseconds)
        .slide(
          begin: const Offset(0, 1),
          end: Offset.zero,
          duration: 500.milliseconds,
        )
        .then()
        .animate(delay: 6500.milliseconds)
        .scaleXY(end: 0.97, duration: 50.milliseconds)
        .then()
        .scaleXY(end: 1 / 0.97, duration: 50.milliseconds)
        .then()
        .scaleXY(delay: 300.milliseconds, end: 0.97, duration: 50.milliseconds)
        .then()
        .scaleXY(end: 1 / 0.97, duration: 50.milliseconds);
  }

  Widget _buildText() {
    return const DefaultTextStyle(
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            Text('WINTER WOLF'),
            Spacer(),
            Text('APP GAMES'),
          ],
        ),
      ),
    ).animate(delay: 1000.milliseconds).fade(duration: 200.milliseconds).slide(
          begin: const Offset(0, 1),
          end: Offset.zero,
          duration: 500.milliseconds,
        );
  }

  Widget _buildHeart() {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(bottom: 0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white54.withOpacity(0.2),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: upPoint
                      ? keepBase
                          ? _heart(key: _baseFirstHeartKey)
                          : _heart(key: _baseFirstHeartKey)
                              .animate()
                              .scale(duration: 200.milliseconds)
                              .then()
                              .shake(duration: 300.milliseconds)
                              .then()
                              .callback(
                                callback: (value) {
                                  _targetFirstOffset = _calculateTargetOffset(
                                    to: _targetHeartKey,
                                    from: _baseFirstHeartKey,
                                  );
                                },
                              )
                              .then()
                              .move(
                                delay: 1000.milliseconds,
                                duration: 200.milliseconds,
                                end: _targetFirstOffset,
                              )
                      : _animateInactiveHeartWidget()
                          .then()
                          .callback(
                            callback: (value) {
                              setState(() {
                                upPoint = true;
                                Future.delayed(3000.milliseconds).then((value) {
                                  setState(() {
                                    keepBase = true;
                                  });
                                });
                              });
                            },
                          )
                          .then()
                          .animate(delay: 1.seconds)
                          .callback(
                            callback: (value) {
                              print('>>>>>> Done');
                            },
                          ),
                ),
                Expanded(
                  child: upPoint
                      ? keepBase
                          ? _heart(key: _baseSecondHeartKey)
                          : _heart(key: _baseSecondHeartKey)
                              .animate()
                              .scale(duration: 200.milliseconds)
                              .then()
                              .shake(duration: 300.milliseconds)
                              .then()
                              .callback(
                                callback: (value) {
                                  _targetSecondOffset = _calculateTargetOffset(
                                    to: _targetHeartKey,
                                    from: _baseSecondHeartKey,
                                  );
                                },
                              )
                              .then()
                              .move(
                                delay: 1300.milliseconds,
                                duration: 200.milliseconds,
                                end: _targetSecondOffset,
                              )
                      : _animateInactiveHeartWidget(),
                ),
                Expanded(child: _animateInactiveHeartWidget()),
              ],
            ),
            _backHeartRow(),
          ],
        ),
      ).animate(delay: 1.seconds).fade(duration: 200.milliseconds).slide(
            begin: const Offset(0, 1),
            end: Offset.zero,
            duration: 500.milliseconds,
          ),
    );
  }

  Offset _calculateTargetOffset({
    required GlobalKey to,
    required GlobalKey from,
  }) {
    final renderBoxB = to.currentContext!.findRenderObject() as RenderBox;
    final positionB = renderBoxB.localToGlobal(Offset.zero);
    final renderBoxA = from.currentContext!.findRenderObject() as RenderBox;
    final positionA = renderBoxA.localToGlobal(Offset.zero);

    return Offset(
      positionB.dx - positionA.dx,
      positionB.dy - positionA.dy,
    );
  }

  Widget _backHeartRow() {
    return AnimatedSwitcher(
      duration: 1000.milliseconds,
      child: !upPoint
          ? const SizedBox()
          : Row(
              children: List.filled(
                3,
                Expanded(
                  child: _heart(color: Colors.red[400]!.withOpacity(0.3)),
                ),
              ),
            ),
    );
  }

  Widget _heart({
    Key? key,
    Color? color,
    double width = 60,
    double height = 60,
  }) {
    return Image.asset(
      key: key,
      color: color,
      Assets.images.icHeartSmall.path,
      width: width,
      height: height,
    );
  }

  Animate _animateInactiveHeartWidget() {
    return _heart(color: Colors.red[400]!.withOpacity(0.3))
        .animate(delay: 2.seconds)
        .scaleXY(end: 0.5, duration: 500.milliseconds)
        .then()
        .scaleXY(end: 2.0, duration: 500.milliseconds)
        .then()
        .scaleXY(end: 0.5, duration: 500.milliseconds)
        .then()
        .scaleXY(end: 2.0, duration: 500.milliseconds);
  }
}
