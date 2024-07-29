// Classe pour les codes ANSI des couleurs
class AnsiColor {
  final String code;

  const AnsiColor._(this.code);

  static const AnsiColor reset = AnsiColor._('\x1B[0m');
  static const AnsiColor red = AnsiColor._('\x1B[31m');
  static const AnsiColor green = AnsiColor._('\x1B[32m');
  static const AnsiColor blue = AnsiColor._('\x1B[34m');
  static const AnsiColor yellow = AnsiColor._('\x1B[33m');
  static const AnsiColor magenta = AnsiColor._('\x1B[35m'); // Violet
  static const AnsiColor cyan = AnsiColor._('\x1B[36m');
  static const AnsiColor white = AnsiColor._('\x1B[37m');
// Ajoute d'autres couleurs si nécessaire
}
