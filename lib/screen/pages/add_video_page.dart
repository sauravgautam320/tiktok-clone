import 'package:camera/camera.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:camerawesome/models/orientations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:itsurshow/repository/fake_repository.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddVideoPage extends StatefulWidget {
  @override
  _AddVideoPageState createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  // Notifiers
  ValueNotifier<CameraFlashes> _switchFlash = ValueNotifier(CameraFlashes.NONE);
  ValueNotifier<Sensors> _sensor = ValueNotifier(Sensors.BACK);
  ValueNotifier<CaptureModes> _captureMode = ValueNotifier(CaptureModes.VIDEO);
  ValueNotifier<Size> _photoSize = ValueNotifier(null);

  // Controllers
  VideoController _videoController = new VideoController();
  CameraController _cameraController;
  List<CameraDescription> cameras;

  TextStyle _textStyle = TextStyle(fontSize: 12);
  int _pageSelectedIndex = 1;
  bool _flash = false;

  @override
  void initState() {
    _initializedCamera();
    super.initState();
  }

  _initializedCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((value) {
      if (!mounted) return;

      setState(() {});
    });
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
              CameraAwesome(
                testMode: false,
                onPermissionsResult: (bool result) {},
                selectDefaultSize: (List<Size> availableSizes) =>
                    Size(1920, 1080),
                onCameraStarted: () {},
                onOrientationChanged: (CameraOrientations newOrientation) {},
                sensor: _sensor,
                photoSize: _photoSize,
                switchFlashMode: _switchFlash,
                captureMode: _captureMode,
                orientation: DeviceOrientation.portraitUp,
              ),
              _topRowWidget(),
              _rghtColumnWidgets(),
              _bottomRowWidget(),
              _bottomWidget(),
            ],
          ),
        );
      },
    );
  }

  Widget _topRowWidget() {
    return Positioned(
      top: 30,
      left: 10,
      right: 10,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close)),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.music_note),
                  Text('Sounds'),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                InkWell(onTap: () {}, child: Icon(Icons.flip)),
                Text(
                  'Flip',
                  style: _textStyle,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _rghtColumnWidgets() {
    return Positioned(
      right: 10,
      top: 80,
      child: Column(
        children: <Widget>[
          // Container(
          //   child: Column(
          //     children: <Widget>[
          //       Icon(Icons.shutter_speed),
          //       Text(
          //         'Speed',
          //         style: _textStyle,
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // Container(
          //   child: Column(
          //     children: <Widget>[
          //       Icon(Icons.filter_tilt_shift),
          //       Text(
          //         'Filter',
          //         style: _textStyle,
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          // Container(
          //   child: Column(
          //     children: <Widget>[
          //       Icon(Icons.color_lens),
          //       Text(
          //         'Beautify',
          //         style: _textStyle,
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Container(
            child: Column(
              children: <Widget>[
                Icon(Icons.timer),
                Text(
                  'Timer',
                  style: _textStyle,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                InkWell(
                    onTap: () {
                      setState(() {
                        _switchFlash.value = CameraFlashes.ON;
                        _flash = !_flash;
                      });
                    },
                    child: _flash == false
                        ? Icon(Icons.flash_off)
                        : Icon(Icons.flash_auto)),
                Text(
                  'Flash',
                  style: _textStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomRowWidget() {
    return Positioned(
      bottom: 50,
      left: 10,
      right: 10,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.purple.withOpacity(0.4),
                        Colors.blue.withOpacity(0.4),
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset('assets/effects/effects.png'),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Effects',
                    style: _textStyle,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.4),
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                //border: Border.all(color: Colors.black, width: 1),
              ),
              child: InkWell(
                onTap: () async {
                  await _videoController
                      .recordVideo('THE_IMAGE_PATH/myvideo.mp4');
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    border: Border.all(color: Colors.black87, width: 1),
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Image.asset('assets/effects/gallery.png'),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Upload',
                    style: _textStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
        ),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              itemCount: FakeRepository.dataList.length,
              onPageChanged: (int index) {
                setState(() {
                  _pageSelectedIndex = index;
                });
              },
              scrollDirection: Axis.horizontal,
              controller: PageController(
                initialPage: 1,
                keepPage: true,
                viewportFraction: 0.2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${FakeRepository.dataList[index]}',
                    style: TextStyle(
                        color: _pageSelectedIndex == index
                            ? Colors.white
                            : Colors.grey),
                  ),
                );
              },
            ),
            Positioned(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
