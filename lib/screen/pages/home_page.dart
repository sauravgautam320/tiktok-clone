import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:marquee/marquee.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';

import '../../repository/fake_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  VideoPlayerController _videoPlayerController;
  bool _isPlaying = true;
  int _followingAndForYouController = 0;

  TextStyle _followingAndForYouStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);

  AnimationController _animationController;

  @override
  void initState() {
    _videoPlayerController =
        VideoPlayerController.asset('assets/videos/tik.mp4')
          ..initialize()
          ..setLooping(false)
          ..play().then((value) {
            setState(() {});
          });
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (
        BuildContext buildcontext,
        SizingInformation sizingInformation,
      ) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.vertical,
                itemCount: FakeRepository.data.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return Stack(
                    children: <Widget>[
                      _videoPlayerList(),
                      _rightSideButtonsWidget(index),
                      _textDataWidgetBottom(sizingInformation, index),
                    ],
                  );
                },
              ),
              _topWidgetFollowingAndForYou(),
            ],
          ),
        );
      },
    );
  }

  Widget _videoPlayerList() {
    if (_videoPlayerController.value.initialized) {
      return Container(
        child: InkWell(
          onTap: () {
            if (_videoPlayerController.value.isPlaying) {
              _isPlaying = false;
              _videoPlayerController.pause();
            } else {
              _isPlaying = true;
              _videoPlayerController.play();
            }
          },
          child: VideoPlayer(_videoPlayerController),
        ),
      );
    }
  }

  Widget _topWidgetFollowingAndForYou() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _followingAndForYouController = 0;
                });
              },
              child: Text(
                'Following',
                style: _textStyleFollowingAndForYou(
                    _followingAndForYouController == 0
                        ? Colors.white
                        : Colors.white60),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '|',
              style: _followingAndForYouStyle,
            ),
            SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _followingAndForYouController = 1;
                });
              },
              child: Text(
                'For You',
                style: _textStyleFollowingAndForYou(
                    _followingAndForYouController == 1
                        ? Colors.white
                        : Colors.white60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyleFollowingAndForYou(Color color) {
    return TextStyle(fontSize: 22, color: color, fontWeight: FontWeight.w500);
  }

  Widget _rightSideButtonsWidget(int index) {
    return Positioned(
      right: 10,
      bottom: 50,
      child: Column(
        children: <Widget>[
          Container(
            height: 70,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 1.5,
                      ),
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                      child: Image.asset(
                        FakeRepository.data[index].profileUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 20,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidHeart,
                  size: 35,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${FakeRepository.data[index].boomsCount}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidComment,
                  size: 35,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${FakeRepository.data[index].commentsCount}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.share,
                  size: 35,
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '${FakeRepository.data[index].sharesCount}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AnimatedBuilder(
            builder: (BuildContext buildContext, Widget child) {
              return Transform.rotate(
                angle: _animationController.value * 6.3,
                child: child,
              );
            },
            animation: _animationController,
            child: Container(
              padding: EdgeInsets.all(5),
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  child: Image.asset(
                    FakeRepository.data[index].profileUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textDataWidgetBottom(SizingInformation sizingInformation, int index) {
    return Positioned(
      bottom: 20,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Filter'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${FakeRepository.data[index].name}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: sizingInformation.localWidgetSize.width * 0.80,
            child: Text(
              '${FakeRepository.data[index].description}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: sizingInformation.localWidgetSize.width * 0.70,
            child: Text(
              '${FakeRepository.data[index].tags}',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 25,
                  width: sizingInformation.localWidgetSize.width * 0.60,
                  child: Marquee(
                    text: '${FakeRepository.data[index].musicName}',
                    pauseAfterRound: Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: Duration(seconds: 1),
                    decelerationCurve: Curves.easeOut,
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
