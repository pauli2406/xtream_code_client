import 'package:json_annotation/json_annotation.dart';
import 'package:xtream_code_client/src/utils/json_helper.dart';

part 'channel_epg.g.dart';

@JsonSerializable()
class ChannelEpg {

  ChannelEpg({required this.epg_listings});

  factory ChannelEpg.fromJson(Map<String, dynamic> json) =>
      _$ChannelEpgFromJson(json);
  final List<EpgListing> epg_listings;

  Map<String, dynamic> toJson() => _$ChannelEpgToJson(this);
}

@JsonSerializable()
class EpgListing {

  EpgListing({
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

  factory EpgListing.fromJson(Map<String, dynamic> json) =>
      _$EpgListingFromJson(json);
  final String id;
  @JsonKey(name: 'epg_id')
  final String epgId;
  final String title;
  final String lang;
  final DateTime start;
  @JsonKey(fromJson: dateTimeFromEpochSeconds)
  final DateTime end;
  final String description;
  @JsonKey(name: 'channel_id')
  final String channelId;
  @JsonKey(name: 'start_timestamp', fromJson: dateTimeFromEpochSeconds)
  final DateTime startTimestamp;
  @JsonKey(name: 'stop_timestamp', fromJson: dateTimeFromEpochSeconds)
  final DateTime stopTimestamp;
  final DateTime stop;

  Map<String, dynamic> toJson() => _$EpgListingToJson(this);
}
