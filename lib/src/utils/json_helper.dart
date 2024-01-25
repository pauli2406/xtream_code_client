DateTime dateTimeFromEpochSeconds(int seconds) =>
    DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

DateTime dateTimeFromString(String dateTime) => DateTime.parse(dateTime);

bool intToBool(int value) => value == 1;
