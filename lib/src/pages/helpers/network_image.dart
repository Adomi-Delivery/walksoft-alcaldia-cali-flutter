import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

Future<ui.Image> loadImage(String uri) async {
  final data = await Dio().get(
    uri,
    options: Options(responseType: ResponseType.bytes),
  );

  final bytes = data.data;

  final imageCodec = await ui.instantiateImageCodec(bytes,
      targetHeight: 100, targetWidth: 100);

  final frame = await imageCodec.getNextFrame();

  final image = await (frame.image.toByteData(format: ui.ImageByteFormat.png)
      as FutureOr<ByteData>);

  return await decodeImageFromList(image.buffer.asUint8List());
}
