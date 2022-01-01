String convertTime(String minutes) {
  if (minutes.length == 1) {
    return "0" + minutes;
  } else {
    return minutes;
  }
}

enum EntryError {
  HeadingDuplicate,
  HeadingNull,
  Details,
  StartTime,
  None,
}
enum Categoryn {
  Work,
  School,
  Health,
  Leisure,
  Others,
}

class Note {
  final String notificationIDs;
  final String noteHeading;
  final String noteDetails;
  final String category;
  final String startTime;

  Note(
      {required this.notificationIDs,
      required this.noteHeading,
      required this.noteDetails,
      required this.category,
      required this.startTime});

  Map<String, dynamic> toJson() {
    return {
      "ids": notificationIDs,
      "heading": noteHeading,
      "details": noteDetails,
      "category": category,
      "start": startTime,
    };
  }

  factory Note.fromJson(Map<String, dynamic> parsedJson) {
    return Note(
      notificationIDs: parsedJson['ids'],
      noteHeading: parsedJson['heading'],
      noteDetails: parsedJson['details'],
      category: parsedJson['category'],
      startTime: parsedJson['start'],
    );
  }
}
