import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class GraphicProvider with ChangeNotifier {

  TextEditingController _textController = TextEditingController();
  Color _backgroundColor = Colors.white;
  XFile? _image;
  bool _isBackground = false;
  bool _isDrawing = false;
  List<Offset?> _points = [];

  TextEditingController get textController => _textController;
  Color get backgroundColor => _backgroundColor;
  XFile? get image => _image;
  bool get isBackground => _isBackground;
  bool get isDrawing => _isDrawing;
  List<Offset?> get points => _points;


  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = pickedFile;
      notifyListeners();
    }
  }

  textBackground() {
    _isBackground = !_isBackground;
    notifyListeners();

    log(_isBackground.toString());

  }

  Future<String> getPersonalFolder() async {
    final downloadsDirectory = await AndroidPathProvider.downloadsPath;
    final personalFolderPath = '$downloadsDirectory/Tiinver App';
    Directory personalFolder = Directory(personalFolderPath);

    if (!await personalFolder.exists()) {
      personalFolder.createSync(recursive: true);
    }
    return personalFolder.path;
  }

  Future<bool> requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      await getPersonalFolder();
      return true;
    } else {
      return false;
    }
  }

  void pickColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }

  Future<String> generateUniqueFileName(String extension) async {
    final personalFolder = await getPersonalFolder();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '$personalFolder/image_$timestamp.$extension';
  }

  Future<String> saveImage(Uint8List imageBytes) async {
    if (await requestPermissions()) {
      // Use android_path_provider to get the Downloads directory
      final uniqueFileName = await generateUniqueFileName('png');
      final imageFile = File(uniqueFileName);
      await imageFile.writeAsBytes(imageBytes);
      return uniqueFileName;
    } else {
      throw Exception('Storage permission not granted');
    }
  }

  void startDrawing() {
    _isDrawing = !_isDrawing;
    notifyListeners();
  }

  void addPoint(Offset? point) {
    _points.add(point);
    notifyListeners();
  }

  void clearPoints() {
    _points.clear();
    notifyListeners();
  }

}