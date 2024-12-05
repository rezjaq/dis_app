import 'dart:io';

import 'package:image_picker/image_picker.dart';

class BoundBox {
  final double x;
  final double y;
  final double width;
  final double height;

  BoundBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory BoundBox.fromJson(Map<String, dynamic> json) {
    return BoundBox(
      x: json['x'],
      y: json['y'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    };
  }
}

class Face {
  final String id;
  final String url;
  final String userId;
  final List<BoundBox> detections;

  Face({
    required this.id,
    required this.url,
    required this.userId,
    required this.detections,
  });

  factory Face.fromJson(Map<String, dynamic> json) {
    var list = json['detections'] as List;
    List<BoundBox> detectionsList =
        list.map((i) => BoundBox.fromJson(i)).toList();
    return Face(
      id: json['id'],
      url: json['url'],
      userId: json['userId'],
      detections: detectionsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'userId': userId,
      'detections': detections.map((e) => e.toJson()).toList(),
    };
  }
}

class FaceDetectionRequest {
  final XFile file;

  FaceDetectionRequest({
    required this.file,
  });
}