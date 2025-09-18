String timeAgoOrToday(dynamic input) {
  try {
    if (input == null) return "";

    DateTime date;

    if (input is DateTime) {
      date = input;
    } else if (input is String) {
      date = DateTime.tryParse(input) ?? DateTime.now();
    } else if (input is int) {
      // treat as timestamp (milliseconds since epoch)
      date = DateTime.fromMillisecondsSinceEpoch(input, isUtc: false);
    } else {
      return "";
    }

    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return "today";
    } else if (difference > 0) {
      return "$difference days ago";
    } else {
      return "in ${difference.abs()} days"; // future date handling
    }
  } catch (e) {
    return "";
  }
}
