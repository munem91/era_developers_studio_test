//A method that moves the last 1 words to a new line
String getFormattedTitle(String title) {
  List<String> words = title.split(' ');
  if (words.length > 1) {
    String lastWord = words.removeLast();
    return '${words.join(' ')}\n$lastWord';
  }
  return title;
}

//A method that moves the last 2 words to a new line
String addLineBreakBeforeLastTwoWords(String text) {
  List<String> words = text.split(' ');
  if (words.length > 2) {
    String lastWord = words.removeLast();
    String secondLastWord = words.removeLast();
    return words.join(' ') + '\n' + secondLastWord + ' ' + lastWord;
  }
  return text;
}
