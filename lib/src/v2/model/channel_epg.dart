class ChannelEpg {
  const ChannelEpg({required this.epgListings});

  final List<EpgListing>? epgListings;
}

class EpgListing {
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

  final int? id;
  final int? epgId;
  final String? title;
  final String? lang;
  final DateTime? start;
  final DateTime? end;
  final String? description;
  final String? channelId;
  final DateTime? startTimestamp;
  final DateTime? stopTimestamp;
  final DateTime? stop;
}
