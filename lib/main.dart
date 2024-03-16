import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:qr/qr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const tvipMediaData =
      'https://test.tvip.media/client/activate?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2NGNjZGIxZi02Y2VjLTQ3MmMtOGIyNy02ZDAzYWYzNGY1MGYiLCJpYXQiOjE3MDkzNTkyMDAsImV4cCI6MTcwOTM2NjQwMCwiaW5mbyI6IntcIm5hbWVcIjpcIlRTUFwiLFwidGhlbWVcIjpudWxsLFwiaWRcIjoxODk4Nzg1Mzk2LFwibGdcIjpudWxsfSIsImF1dGgiOiJcIjFcIiIsImxpc3QiOiJbXCJERVZJQ0VfVU5BVVRIT1JJWkVEXCJdIn0.7yI5Hb02Fqi8BtzTo0XSXxHLZQigmsOxdhqnQmhx6eA';
  static const msTestData =
      'https://ms-test.tvip.ru/client/activate?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyZDcwNDE2NC1hMmRkLTRjZGUtYjk4Yi0wOWQ5NmM4ZDM3YjQiLCJpYXQiOjE3MTA0ODI0MDAsImV4cCI6MTcxMDQ4OTY2MCwiaW5mbyI6IntcIm5hbWVcIjpcIlRTUFwiLFwidGhlbWVcIjpudWxsLFwiaWRcIjoxMzg4NzgwNzQyLFwibGdcIjpcImh0dHBzOi8vbXMtdGVzdC50dmlwLnJ1L2ltYWdlL3BuZy84MzcyMzg3LyUyNCU3QnclN0QvJTI0JTdCaCU3RC8lMjQlN0Jtb2RlJTdEL2xvZ28ucG5nXCJ9IiwiYXV0aCI6IlwiMVwiIiwibGlzdCI6IltcIkRFVklDRV9VTkFVVEhPUklaRURcIl0ifQ.nXPRtdXHxeJDd0rItFBvk4o-n-TDFFOf-Cj3lzZk0Mk';
  static const bigData =
      'CZtjqn05AaEmiOAe5VdIopECaVGl+8M8xQsii7yAcFHo0NyIPVTLcUXRFiIUJHHGLj4CUK/rvGfTqF4LIGeGqnFi/z8xgf3iSbaFCIedF7IOVAvhgjZMCjQfnD2wxKrOUshkuWBgMElzghlaLTg+uh6oe+eCB8HQuBo7D+sKPC3KnOx72lXnoJqLp+ZV1O0DOK9tW7NNDw21O1fna2pjujVuVsZEw5vLCIDND9RiQPFwSUsob8fNRixtHh1+f7RIHyBgpnA9iLh909OZG7OhMwUKU9dxABtq4tqUmG/IvdcAhUPmL/mLGWBE7q1NvyHiH/TP1wIpO62yyAGn6CyHfTg6Y+6MEDJUh4AS0axuTJpPY4v4Q7k2tCOhk7JZhl1kA6Xrjq8zl8RWyIvRxUaoe8RuP1AxnzvacUaloQcKfi7YYRxW+8Xe6tUUxw7dCSQHkrxX7DZFU/xIpXYZgeXAJcz205fmIGrO7ejWJAqZSr1YS4I7+wWHlZc0ajxv73I7lmkqVgnsE1uy86lu7lOe8t5UQYohsdZFzBOnuYlVVto+Zfy2OaYkCalAXTi+C0B3ic0h1iONtywt/qpxZEymLHJlCVaALOoLJGm2e2GYvGc9GdyrzzfXidd5NeKc+oPHlxsZcWtifnEqwdne0jv8RnsfbEWAM6t5l7wsYONLqvYYByrZfFMl0ShDEYj/QHPEgnvxnvS3CrMv9UibJyZUzZgltHVAytwRQklBARObhEalJt8OS2ZOGbU1Dnrj5Roy/S7HTbZQ9E0GKUyFFInBAiINUIy79NsqUH4UcUPnT5H5vW+ZobWkVHZmF0GLx31h5IWBIPJFU2xSLMY3y5+HUCi7+JnUGCmAq6fPQSmU6OV4+pvKzB2E71AbJlSwMpNcNIp/6/jurNcsgXB7gw0qBC/lBPHAOXs8IlLgTGcUrwGKVehBxUvX0YrOUblPM8n/znhHQUin5lKhwlcdMf+FkU80u6mCK6cdvF3TtHS6ixdLa59WTAtUl6XqSs49I4xffArBML177szUAQq2ptRyG+AElDpFBcrB6KNhjD3z+fVvYvfWsSK3PWRvUXjgrghnph2zZ4a6VvL1MSHTlYH5lUCUgTKizATWs/jvKZVyf6YSnNHQfgBvDvb45MM+Kvwy5chZ8C0wFIQxUURHUUpJceyhzzOU3+F0+x4Z+YFMOK1mqPLGgNVhCFy9xFaCzC8TgxdVoYvxipG3qaMMPhak3RvyzCwQYnvJjXFzjx3t7YoU4eVqFJNYP6pz1S8Z5tx4AWDqAlhRze/GG9c1HE6E4hdRxmKnVHLF40kZJC/pZqoaVtm/r+a1Ssiqm3Fl3JkdxQ0MXpDit0ukq2lxmLTb4a3I3ryGl85yZf4cU1kWKWQ3lL8Pj5niaxVAamczL93IWD1D2d8pqORxxBcsUY3eBZjV3zbcX9LEsIIX';
  static const double qrCodeWidgetSize = 260;
  static const qrCodeWidgetPadding = EdgeInsets.all(20);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var qr;

  @override
  void initState() {
    super.initState();
    _generateQrCode();
  }

  void _generateQrCode() {
    final qrCode = QrCode.fromData(
        data: MyHomePage.bigData, errorCorrectLevel: QrErrorCorrectLevel.L);
    //QrCode(20, QrErrorCorrectLevel.L)..addData(MyHomePage.tvipMediaData);
    final qrImage = QrImage(qrCode);

    qr = CustomPaint(
      size: const Size.square(MyHomePage.qrCodeWidgetSize),
      painter: QrPainter(qrImage, color: Colors.black),
    );
  }

  ui.Image getQrImage() {
    final qrCode = QrCode.fromData(
        data: MyHomePage.tvipMediaData,
        errorCorrectLevel: QrErrorCorrectLevel.L);
    final qrImage = QrImage(qrCode);
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    QrPainter(qrImage, color: Colors.black).paint(
        Canvas(recorder), const Size.square(MyHomePage.qrCodeWidgetSize));
    final ui.Picture picture = recorder.endRecording();
    final imageSide = MyHomePage.qrCodeWidgetSize.round();
    return picture.toImageSync(imageSide, imageSide);
  }

  Future<Uint8List> encodeImage() async {
    final byteData =
        await getQrImage().toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) return Uint8List.view(byteData.buffer);
    throw Error();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ColoredBox(
              color: Colors.white,
              child: Padding(
                padding: MyHomePage.qrCodeWidgetPadding,
                child: qr,
              )),
          ColoredBox(
            color: Colors.white,
            child: SizedBox.square(
              child: Padding(
                padding: MyHomePage.qrCodeWidgetPadding,
                child: FutureBuilder(
                  future: encodeImage(),
                  builder: (_, AsyncSnapshot<Uint8List> snapshot) {
                    if (snapshot.hasData) {
                      return Image.memory(snapshot.data!);
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class QrPainter extends CustomPainter {
  final QrImage qrImage;
  final Color color;

  QrPainter(this.qrImage, {required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final quadsCount = qrImage.moduleCount;
    final lastQuadIndex = quadsCount - 1;
    final quadSide = (size.width / quadsCount);
    final quadHeight = quadSide * 1.1;
    for (int y = 0; y < quadsCount; y++) {
      final top = y * quadSide;
      int len = 0;
      for (int x = 0; x < quadsCount; x++) {
        switch (qrImage.isDark(y, x)) {
          case true when x == lastQuadIndex:
            len++;
            x++;
            continue draw;
          draw:
          case false when len > 0:
            final left = (x - len) * quadSide;
            canvas.drawRect(
                Rect.fromLTWH(left, top, quadSide * len, quadHeight), paint);
            len = 0;
          case true:
            len++;
          default:
        }
      }
    }
  }

  @override
  bool shouldRepaint(oldDelegate) => false;
}
