import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  List<Message> messageList = [
    Message(text: 'Hola', fromWho: FromWho.me),
    Message(
        text: 'Jesús, ¿te vas a ir a especial de móviles en Progreso?',
        fromWho: FromWho.me),
  ];
}
