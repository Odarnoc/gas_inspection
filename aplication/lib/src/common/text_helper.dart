class TextHelper {
  static int maxLength = 15;
  static String getOnlyFistName(String fullName) {
    int indexOfSpace = fullName.indexOf(' ', 0);
    if (indexOfSpace == -1) {
      return smallSentence(fullName);
    }

    return smallSentence(fullName.substring(0, indexOfSpace));
  }

  static String smallSentence(String bigSentence) {
    if (bigSentence.length > maxLength) {
      return '${bigSentence.substring(0, maxLength)}...';
    } else {
      return bigSentence;
    }
  }
}
