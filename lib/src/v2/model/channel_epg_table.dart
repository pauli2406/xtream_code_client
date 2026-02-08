class ChannelEpgTable {
  const ChannelEpgTable({required this.epgListings});

  final List<EpgTableListing>? epgListings;
}

class EpgTableListing {
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
  final bool? nowPlaying;
  final bool? hasArchive;
}
