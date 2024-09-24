import 'dart:convert';
import 'dart:io';

Map<String, dynamic> jsonFromFile(String filePath) => _jsonDecodeFromFile(filePath);

List<Map<String, dynamic>> jsonListFromFile(String filePath) {
  final jsonList = _jsonDecodeFromFile(filePath) as List;
  return jsonList.map((e) => e as Map<String, dynamic>).toList();
}

dynamic _jsonDecodeFromFile(String filePath) => jsonDecode(File(filePath).readAsStringSync());
