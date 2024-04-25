import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_firefighter/core/vision.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  late ByteData testImage;
  List<Map<String, dynamic>> result = [];

  @override
  void initState() {
    super.initState();
    ref.read(objectModelProvider);
    rootBundle.load('assets/harold.jpeg').then((value) {
      setState(() {
        testImage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Consumer(
        child: const CircularProgressIndicator(),
        builder: (context, ref, child) {
          final objectModel = ref.watch(objectModelProvider);
          return objectModel.maybeWhen(
            orElse: () => child!,
            data: (data) {
              data
                  .yoloOnImage(
                      bytesList: testImage.buffer.asUint8List(),
                      imageHeight: 1024,
                      imageWidth: 683,
                      iouThreshold: 0.8,
                      confThreshold: 0.4,
                      classThreshold: 0.7)
                  .then((value) {
                setState(() {
                  result = value;
                });
              });

              return Column(
                children: [
                  Expanded(child: Image.memory(testImage.buffer.asUint8List())),
                  result.isNotEmpty
                      ? Flexible(
                          child: ListView.builder(
                            itemCount: result.length,
                            itemBuilder: (context, index) {
                              final resultVal = result[index];
                              return ListTile(
                                title: Text(resultVal['tag']),
                              );
                            },
                          ),
                        )
                      : const Text('No Results')
                ],
              );
            },
          );
        },
      ),
    );
  }
}
