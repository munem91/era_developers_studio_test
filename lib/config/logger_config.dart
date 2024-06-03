// lib/config/logger_config.dart
import 'package:logger/logger.dart';

// Создайте глобальный экземпляр Logger
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2, // Количество отображаемых вызовов методов
    errorMethodCount:
        8, // Количество вызовов методов, если предоставлен стек ошибок
    lineLength: 120, // Ширина вывода
    colors: true, // Цветные сообщения журнала
    printEmojis: true, // Печать эмодзи для каждого сообщения журнала
    printTime: false, // Должен ли каждый журнал содержать временную метку
  ),
);
