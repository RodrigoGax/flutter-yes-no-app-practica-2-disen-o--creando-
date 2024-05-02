import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  //Controlador para manejar la posición del scroll
  final ScrollController chatScrollController = ScrollController();
  //Instancia de la clase GetYesNoAnswer
  final getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: 'Hola', fromWho: FromWho.me),
    Message(
        text: 'Jesús, ¿te vas a ir a especial de móviles en Progreso?',
        fromWho: FromWho.me),
  ];

  //Método para enviar mensaje
  Future<void> sendMessage(String text) async {
    //Evitar que el mensaje se envíe vacío
    if (text.isEmpty) return;
    //El mensaje siempre va a ser de "me" (o mío) porque
    //yo, el usuario, siempre será el que envíe el mensaje
    final newMessage = Message(text: text, fromWho: FromWho.me);
    //Agregar un mensaje a la lista
    messageList.add(newMessage);
    //Detecta si el usuario hizo una pregunta para desencadenar la respuesta "ella"
    if (text.endsWith('?')) {
      herReply();
    }

    //Notificar si algo de provider cambió
    //para que se guarde en el estado
    notifyListeners();
    moveScrollToBottom();
  }

  //Creará la respuesta de "ella"
  Future<void> herReply() async {
    //Obtener petición y almacenarlo en una variable
    final herMessage = await getYesNoAnswer.getAnswer();
    //Añadir en la lista de mensajes
    messageList.add(herMessage);
    //Notificar si algo de provider cambió para que se guarde en el estado
    notifyListeners();
    //Mueve el scroll hasta el último mensaje recibido
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
