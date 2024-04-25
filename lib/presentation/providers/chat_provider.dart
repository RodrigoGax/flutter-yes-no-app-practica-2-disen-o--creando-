import 'package:flutter/material.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  //Controlador para manejar la posición del scroll
  final ScrollController chatScrollController = ScrollController();

  List<Message> messageList = [
    Message(text: 'Hola', fromWho: FromWho.me),
    Message(
        text: 'Jesús, ¿te vas a ir a especial de móviles en Progreso?',
        fromWho: FromWho.me),
  ];

  //Método para enviar mensaje
  Future<void> sendMessage(String text) async {
    //El mensaje siempre va a ser de "me" (o mío) porque
    //yo, el usuario, siempre será el que envíe el mensaje
    final newMessage = Message(text: text, fromWho: FromWho.me);
    //Agregar un mensaje a la lista
    messageList.add(newMessage);

    //Notificar si algo de provider cambió
    //para que se guarde en el estado
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    //Un pequeño retraso para garantizar que la
    //animación se vea bien
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        //maxScrollExtent determina lo máximo que el Scroll
        //puede dar
        chatScrollController.position.maxScrollExtent,
        //offset: posición de la animación
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
