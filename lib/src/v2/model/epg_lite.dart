/// Lightweight EPG model optimized for speed and lower memory overhead.
///
/// Date fields are normalized to UTC.
class EpgLite {
  /// Creates a lightweight EPG payload.
  const EpgLite({
    required this.channels,
    required this.programmes,
  });

  /// Parsed channel definitions.
  final List<EpgLiteChannel> channels;

  /// Parsed programme entries.
  final List<EpgLiteProgramme> programmes;
}

/// Lightweight channel entry.
class EpgLiteChannel {
  /// Creates a lightweight channel entry.
  const EpgLiteChannel({
    required this.id,
    required this.displayNames,
  });

  /// Channel id from XMLTV `channel/@id`.
  final String id;

  /// Display names from `display-name` nodes.
  final List<String> displayNames;
}

/// Lightweight programme entry.
class EpgLiteProgramme {
  /// Creates a lightweight programme entry.
  const EpgLiteProgramme({
    required this.channelId,
    this.start,
    this.stop,
    this.title,
    this.description,
  });

  /// Channel id linking to [EpgLiteChannel.id].
  final String channelId;

  /// Programme start timestamp in UTC.
  final DateTime? start;

  /// Programme stop timestamp in UTC.
  final DateTime? stop;

  /// Programme title.
  final String? title;

  /// Programme description.
  final String? description;
}
