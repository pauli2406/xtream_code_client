import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'channel_epg_table.g.dart';

/// Represents a table of EPG (Electronic Program Guide) channels.
@JsonSerializable()
class XTremeCodeChannelEpgTable {
  /// Creates a new instance of [XTremeCodeChannelEpgTable].
  XTremeCodeChannelEpgTable({required this.epgListings});

  /// Creates a new instance of [XTremeCodeChannelEpgTable] from a JSON object.
  factory XTremeCodeChannelEpgTable.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeChannelEpgTableFromJson(json);

  /// A list of EPG listings for this table.
  @JsonKey(name: 'epg_listings')
  final List<XTremeCodeEpgListingTable>? epgListings;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeChannelEpgTableToJson(this);
}

/// Represents a single EPG (Electronic Program Guide) listing in a table.
@JsonSerializable()
class XTremeCodeEpgListingTable {
  /// Creates a new instance of [XTremeCodeEpgListingTable].
  XTremeCodeEpgListingTable({
    required this.id,
    required this.epgId,
    required this.title,
    required this.lang,
    required this.start,
    required this.end,
    required this.description,
    required this.channelId,
    required this.startTimestamp,
    required this.stopTimestamp,
    required this.nowPlaying,
    required this.hasArchive,
  });

  /// Creates a new instance of [XTremeCodeEpgListingTable] from a JSON object.
  factory XTremeCodeEpgListingTable.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeEpgListingTableFromJson(json);

  /// The ID of the EPG listing.
  @JsonKey(fromJson: dynamicToIntConverter)
  final int? id;

  /// The ID of the EPG.
  @JsonKey(name: 'epg_id', fromJson: dynamicToIntConverter)
  final int? epgId;

  /// The title of the EPG listing.
  final String? title;

  /// The language of the EPG listing.
  final String? lang;

  /// The start time of the EPG listing.
  @JsonKey(fromJson: dateTimeFromString)
  final DateTime? start;

  /// The end time of the EPG listing.
  @JsonKey(fromJson: dateTimeFromString)
  final DateTime? end;

  /// The description of the EPG listing.
  final String? description;

  /// The ID of the channel.
  @JsonKey(name: 'channel_id')
  final String channelId;

  /// The start timestamp of the EPG listing.
  @JsonKey(name: 'start_timestamp', fromJson: dateTimeFromEpochSeconds)
  final DateTime? startTimestamp;

  /// The stop timestamp of the EPG listing.
  @JsonKey(name: 'stop_timestamp', fromJson: dateTimeFromEpochSeconds)
  final DateTime? stopTimestamp;

  /// Whether the EPG listing is currently playing.
  @JsonKey(name: 'now_playing', fromJson: dynamicToBool)
  final bool nowPlaying;

  /// Whether the EPG listing has an archive.
  @JsonKey(name: 'has_archive', fromJson: dynamicToBool)
  final bool hasArchive;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeEpgListingTableToJson(this);
}
