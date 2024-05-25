class YoutubeVideoIdHelper {
  static String? getVideoId(String videoLink) {
    RegExp regExp = RegExp(
      r"(?:https:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})",
      caseSensitive: false,
    );
    Match? match = regExp.firstMatch(videoLink);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    } else {
      return null;
    }
  }
}
