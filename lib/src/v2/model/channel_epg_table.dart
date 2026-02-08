/// Table-style EPG payload for a single stream.
///
/// Date fields are normalized to UTC.
class ChannelEpgTable {
  /// Creates table-style EPG data.
  const ChannelEpgTable({required this.epgListings});

  /// Table listings for the requested channel.
  final List<EpgTableListing>? epgListings;
}

/// Table-style EPG listing entry.
class EpgTableListing {
  /// Creates an EPG table listing entry.
  const EpgTableListing({
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
    this.nowPlaying,
    this.hasArchive,
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

  /// Whether this programme is currently playing.
  final bool? nowPlaying;

  /// Whether archive playback is available.
  final bool? hasArchive;
}
