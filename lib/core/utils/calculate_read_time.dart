int calculateReadTime(String content) {
  int wordCount = RegExp(r'\b\w+\b').allMatches(content).length;
  double time = wordCount / 225;
  return time.ceil();
}
