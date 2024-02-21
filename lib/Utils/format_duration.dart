String formatDuration(Duration duration) {
  String formattedDuration = "";
  if (duration.inHours > 0) {
    formattedDuration += "${duration.inHours}h ";
  }
  if (duration.inMinutes > 0) {
    formattedDuration += "${duration.inMinutes}m";
  }
  return formattedDuration;
}
