import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'channel_epg_table.g.dart';

@JsonSerializable()
class ChannelEpgTable {
  final List<EpgListing> epg_listings;

  ChannelEpgTable({required this.epg_listings});

  factory ChannelEpgTable.fromJson(Map<String, dynamic> json) =>
      _$ChannelEpgTableFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelEpgTableToJson(this);
}

@JsonSerializable()
class EpgListing {
  final String id;
  final String epg_id;
  final String title;
  final String lang;
  final DateTime start;
  final DateTime end;
  final String description;
  final String channel_id;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime start_timestamp;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime stop_timestamp;
  @JsonKey(fromJson: intToBool)
  final bool now_playing;
  @JsonKey(fromJson: intToBool)
  final bool has_archive;

  EpgListing({
    required this.id,
    required this.epg_id,
    required this.title,
    required this.lang,
    required this.start,
    required this.end,
    required this.description,
    required this.channel_id,
    required this.start_timestamp,
    required this.stop_timestamp,
    required this.now_playing,
    required this.has_archive,
  });

  factory EpgListing.fromJson(Map<String, dynamic> json) =>
      _$EpgListingFromJson(json);

  Map<String, dynamic> toJson() => _$EpgListingToJson(this);
}
