import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2x2 Rubik\'s Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CubeScreen(),
    );
  }
}

class CubeState {
  List<List<Color>> faces = [
    [Colors.red, Colors.red, Colors.red, Colors.red], // Front
    [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
    [Colors.green, Colors.green, Colors.green, Colors.green], // Right
    [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
    [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
    [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
  ];

  void reset() {
    faces = [
      [Colors.red, Colors.red, Colors.red, Colors.red], // Front
      [Colors.blue, Colors.blue, Colors.blue, Colors.blue], // Left
      [Colors.green, Colors.green, Colors.green, Colors.green], // Right
      [Colors.yellow, Colors.yellow, Colors.yellow, Colors.yellow], // Back
      [Colors.orange, Colors.orange, Colors.orange, Colors.orange], // Top
      [Colors.white, Colors.white, Colors.white, Colors.white], // Bottom
    ];
  }

  void rotateTop() {
    List<Color> temp = [faces[0][0], faces[0][1]];
    faces[0][0] = faces[1][0];
    faces[0][1] = faces[1][1];
    faces[1][0] = faces[3][1];
    faces[1][1] = faces[3][0];
    faces[3][0] = faces[2][1];
    faces[3][1] = faces[2][0];
    faces[2][0] = temp[0];
    faces[2][1] = temp[1];

    List<Color> top = faces[4];
    faces[4] = [top[2], top[0], top[3], top[1]];
  }

  void rotateBottom() {
    List<Color> temp = [faces[0][2], faces[0][3]];
    faces[0][2] = faces[2][2];
    faces[0][3] = faces[2][3];
    faces[2][2] = faces[3][3];
    faces[2][3] = faces[3][2];
    faces[3][2] = faces[1][3];
    faces[3][3] = faces[1][2];
    faces[1][2] = temp[0];
    faces[1][3] = temp[1];

    List<Color> bottom = faces[5];
    faces[5] = [bottom[2], bottom[0], bottom[3], bottom[1]];
  }

  void rotateRight() {
    List<Color> temp = [faces[0][1], faces[0][3]];
    faces[0][1] = faces[4][1];
    faces[0][3] = faces[4][3];
    faces[4][1] = faces[3][2];
    faces[4][3] = faces[3][0];
    faces[3][0] = faces[5][3];
    faces[3][2] = faces[5][1];
    faces[5][1] = temp[0];
    faces[5][3] = temp[1];

    List<Color> right = faces[2];
    faces[2] = [right[2], right[0], right[3], right[1]];
  }

  void rotateLeft() {
    List<Color> temp = [faces[0][0], faces[0][2]];
    faces[0][0] = faces[5][0];
    faces[0][2] = faces[5][2];
    faces[5][0] = faces[3][1];
    faces[5][2] = faces[3][3];
    faces[3][1] = faces[4][2];
    faces[3][3] = faces[4][0];
    faces[4][0] = temp[0];
    faces[4][2] = temp[1];

    List<Color> left = faces[1];
    faces[1] = [left[2], left[0], left[3], left[1]];
  }
}

class CubeScreen extends StatefulWidget {
  const CubeScreen({Key? key}) : super(key: key);

  @override
  _CubeScreenState createState() => _CubeScreenState();
}

class _CubeScreenState extends State<CubeScreen> {
  CubeState cube = CubeState();

  void resetCube() {
    setState(() {
      cube.reset();
    });
  }

  void rotateTop() {
    setState(() {
      cube.rotateTop();
    });
  }

  void rotateBottom() {
    setState(() {
      cube.rotateBottom();
    });
  }

  void rotateRight() {
    setState(() {
      cube.rotateRight();
    });
  }

  void rotateLeft() {
    setState(() {
      cube.rotateLeft();
    });
  }

  Widget buildFace(List<Color> faceColors) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2.0,
        crossAxisSpacing: 2.0,
      ),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) => Container(color: faceColors[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('2x2 Rubik\'s Cube')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text('Top'),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: buildFace(cube.faces[4]),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Left'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[1]),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    const Text('Front'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[0]),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  children: [
                    const Text('Right'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[2]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Column(
                  children: [
                    const Text('Bottom'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[5]),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const Text('Rear'),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: buildFace(cube.faces[3]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: rotateTop,
                  child: const Text('Rotate Top'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: rotateBottom,
                  child: const Text('Rotate Bottom'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: rotateLeft,
                  child: const Text('Rotate Left'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: rotateRight,
                  child: const Text('Rotate Right'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetCube,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}


