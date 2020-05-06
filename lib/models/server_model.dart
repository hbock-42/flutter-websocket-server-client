import 'dart:io';

class ServerModel {
  final InternetAddress _address;
  InternetAddress get address => _address;
  final String _socketHandlerName;
  String get socketHandlerName => _socketHandlerName;
  final String _scheme;
  String get scheme => _scheme;

  ServerModel(this._address, this._socketHandlerName, this._scheme);
}
