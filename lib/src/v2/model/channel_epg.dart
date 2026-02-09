/// Short EPG payload for a single stream.
///
/// Date fields are normalized to UTC.
class ChannelEpg {
  /// Creates short EPG data.
  const ChannelEpg({required this.epgListings});

  /// Programme listings for the requested channel.
  final List<EpgListing>? epgListings;
}

/// Short EPG listing entry.
class EpgListing {
  /// Creates an EPG listing entry.
  const EpgListing({
    this.id,
    this.epgId,
    this.title,
    this.lang,
    this.start,
    this.end,
    this.description,
    this.channelId,
    this.startTimestamp,
    this.stopTimestamp,
    this.stop,
  });

  /// Internal listing id.
  final int? id;

  /// EPG id if provided.
  final int? epgId;

  /// Programme title.
  final String? title;

  /// Language code.
  final String? lang;

  /// Programme start time in UTC.
  final DateTime? start;

  /// Programme end time in UTC.
  final DateTime? end;

  /// Programme description.
  final String? description;

  /// Channel id.
  final String? channelId;

  /// Alternate start timestamp field normalized to UTC.
  final DateTime? startTimestamp;

  /// Alternate stop timestamp field normalized to UTC.
  final DateTime? stopTimestamp;

  /// Legacy `stop` alias normalized to UTC.
  final DateTime? stop;
}
