import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'channel_epg.g.dart';

/// Represents a channel's EPG (Electronic Program Guide).
@JsonSerializable()
class XTremeCodeChannelEpg {
  /// Creates a new instance of [XTremeCodeChannelEpg].
  XTremeCodeChannelEpg({required this.epgListings});

  /// Creates a new instance of [XTremeCodeChannelEpg] from a JSON object.
  factory XTremeCodeChannelEpg.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeChannelEpgFromJson(json);

  /// A list of EPG listings for this channel.
  final List<XTremeCodeEpgListing> epgListings;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeChannelEpgToJson(this);
}

/// Represents a single EPG (Electronic Program Guide) listing.
@JsonSerializable()
class XTremeCodeEpgListing {
  /// Creates a new instance of [XTremeCodeEpgListing].
  XTremeCodeEpgListing({
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
    required this.stop,
  });

  /// Creates a new instance of [XTremeCodeEpgListing] from a JSON object.
  factory XTremeCodeEpgListing.fromJson(Map<String, dynamic> json) =>
      _$XTremeCodeEpgListingFromJson(json);

  /// The ID of the EPG listing.
  final String? id;

  /// The ID of the EPG.
  @JsonKey(name: 'epg_id')
  final String? epgId;

  /// The title of the EPG listing.
  final String? title;

  /// The language of the EPG listing.
  final String? lang;

  /// The start time of the EPG listing.
  @JsonKey(fromJson: dateTimeFromString)
  final DateTime? start;

  /// The end time of the EPG listing.
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime? end;

  /// The description of the EPG listing.
  final String? description;

  /// The ID of the channel.
  @JsonKey(name: 'channel_id')
  final String? channelId;

  /// The start timestamp of the EPG listing.
  @JsonKey(name: 'start_timestamp', fromJson: dateTimeFromEpochSeconds)
  final DateTime? startTimestamp;

  /// The stop timestamp of the EPG listing.
  @JsonKey(name: 'stop_timestamp', fromJson: dateTimeFromEpochSeconds)
  final DateTime? stopTimestamp;

  /// The stop time of the EPG listing.
  final DateTime? stop;

  /// Converts this instance into a JSON object.
  Map<String, dynamic> toJson() => _$XTremeCodeEpgListingToJson(this);
}
