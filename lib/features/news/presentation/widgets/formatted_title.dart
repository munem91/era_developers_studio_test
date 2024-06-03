String getFormattedTitle(String title) {
  List<String> words = title.split(' ');
  if (words.length > 1) {
    String lastWord = words.removeLast();
    return '${words.join(' ')}\n$lastWord';
  }
  return title;
}
