String formatTimeAgo(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inSeconds < 1) return "now";
  if (difference.inSeconds < 60) return "${difference.inSeconds}s";
  if (difference.inMinutes < 60) return "${difference.inMinutes}m";
  if (difference.inHours < 24) return "${difference.inHours}h";
  if (difference.inDays < 7) return "${difference.inDays}d";
  if (difference.inDays < 30) return "${(difference.inDays / 7).floor()}w";
  if (difference.inDays < 365) return "${(difference.inDays / 30).floor()}mo";
  return "${(difference.inDays / 365).floor()}y";
}
