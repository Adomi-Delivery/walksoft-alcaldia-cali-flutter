import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/model/project.dart';
import 'package:walksoft_alcaldia_cali_flutter/src/pages/helpers/marker_photo_project.dart';
import 'dart:ui' as ui;

import 'network_image.dart';

Future<BitmapDescriptor> getMarkerPhotoProject(Project p) async {
  final recorder = new ui.PictureRecorder();
  final canvas = new ui.Canvas(recorder);
  final size = new ui.Size(0, 0);

  final ui.Image imagen = await loadImage(p.urlImage);

  final markerPhoto = new MarkerPhotoProject(p, imagen);
  markerPhoto.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(100, 100);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
}
