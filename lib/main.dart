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

  static const data =
      'https://test.tvip.media/client/activate?token=eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI2NGNjZGIxZi02Y2VjLTQ3MmMtOGIyNy02ZDAzYWYzNGY1MGYiLCJpYXQiOjE3MDkzNTkyMDAsImV4cCI6MTcwOTM2NjQwMCwiaW5mbyI6IntcIm5hbWVcIjpcIlRTUFwiLFwidGhlbWVcIjpudWxsLFwiaWRcIjoxODk4Nzg1Mzk2LFwibGdcIjpudWxsfSIsImF1dGgiOiJcIjFcIiIsImxpc3QiOiJbXCJERVZJQ0VfVU5BVVRIT1JJWkVEXCJdIn0.7yI5Hb02Fqi8BtzTo0XSXxHLZQigmsOxdhqnQmhx6eA';
  static const double qrCodeWidgetSize = 240;
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
    final qrCode = QrCode(20, QrErrorCorrectLevel.L)..addData(MyHomePage.data);
    final qrImage = QrImage(qrCode);

    qr = CustomPaint(
      size: const Size.square(MyHomePage.qrCodeWidgetSize),
      painter: MyPainter(qrImage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
          child: ColoredBox(
        color: Colors.white,
        child: SizedBox.square(
            child: Padding(padding: MyHomePage.qrCodeWidgetPadding, child: qr)),
      )),
    );
  }
}

class MyPainter extends CustomPainter {
  final QrImage qrImage;

  MyPainter(this.qrImage);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final quadsCount = qrImage.moduleCount;
    final quadSide = MyHomePage.qrCodeWidgetSize / quadsCount;
    for (int x = 0; x < quadsCount; x++) {
      final left = x * quadSide;
      for (int y = 0; y < quadsCount; y++) {
        final top = y * quadSide;
        final color = qrImage.isDark(y, x) ? Colors.black : Colors.white;
        canvas.drawRect(
            Rect.fromLTWH(left, top, quadSide, quadSide), paint..color = color);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
