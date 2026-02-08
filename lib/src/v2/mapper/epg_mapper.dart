import 'package:xtream_code_client/src/v2/core/field_aliases.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/model/channel_epg.dart';
import 'package:xtream_code_client/src/v2/model/channel_epg_table.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

class EpgMapper {
  static ChannelEpg channelEpgFromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final rows = ResponseNormalizer.readObjectListField(
      json,
      'epg_listings',
      context,
      jsonPath,
    );

    final listings = <EpgListing>[];
    for (var index = 0; index < rows.length; index++) {
      listings.add(
          _listing(rows[index], context, '$jsonPath.epg_listings[$index]'));
    }

    return ChannelEpg(epgListings: listings);
  }

  static ChannelEpgTable channelEpgTableFromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final rows = ResponseNormalizer.readObjectListField(
      json,
      'epg_listings',
      context,
      jsonPath,
    );

    final listings = <EpgTableListing>[];
    for (var index = 0; index < rows.length; index++) {
      listings.add(_tableListing(
          rows[index], context, '$jsonPath.epg_listings[$index]'));
    }

    return ChannelEpgTable(epgListings: listings);
  }

  static EpgListing _listing(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final endRaw = FieldAliases.resolve(
      json,
      <String>['end', 'stop', 'stop_timestamp'],
      context,
      '$jsonPath.end',
    );
    final stopRaw = FieldAliases.resolve(
      json,
      <String>['stop', 'end', 'stop_timestamp'],
      context,
      '$jsonPath.stop',
    );

    return EpgListing(
      id: ValueParser.asInt(json['id'], context, '$jsonPath.id'),
      epgId: ValueParser.asInt(json['epg_id'], context, '$jsonPath.epg_id'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      lang: ValueParser.asString(json['lang'], context, '$jsonPath.lang'),
      start:
          ValueParser.asDateTimeUtc(json['start'], context, '$jsonPath.start'),
      end: ValueParser.asDateTimeUtc(endRaw, context, '$jsonPath.end'),
      description: ValueParser.asString(
          json['description'], context, '$jsonPath.description'),
      channelId: ValueParser.asString(
          json['channel_id'], context, '$jsonPath.channel_id'),
      startTimestamp: ValueParser.asDateTimeUtc(
        json['start_timestamp'],
        context,
        '$jsonPath.start_timestamp',
      ),
      stopTimestamp: ValueParser.asDateTimeUtc(
        json['stop_timestamp'],
        context,
        '$jsonPath.stop_timestamp',
      ),
      stop: ValueParser.asDateTimeUtc(stopRaw, context, '$jsonPath.stop'),
    );
  }

  static EpgTableListing _tableListing(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final endRaw = FieldAliases.resolve(
      json,
      <String>['end', 'stop', 'stop_timestamp'],
      context,
      '$jsonPath.end',
    );

    return EpgTableListing(
      id: ValueParser.asInt(json['id'], context, '$jsonPath.id'),
      epgId: ValueParser.asInt(json['epg_id'], context, '$jsonPath.epg_id'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      lang: ValueParser.asString(json['lang'], context, '$jsonPath.lang'),
      start:
          ValueParser.asDateTimeUtc(json['start'], context, '$jsonPath.start'),
      end: ValueParser.asDateTimeUtc(endRaw, context, '$jsonPath.end'),
      description: ValueParser.asString(
          json['description'], context, '$jsonPath.description'),
      channelId: ValueParser.asString(
          json['channel_id'], context, '$jsonPath.channel_id'),
      startTimestamp: ValueParser.asDateTimeUtc(
        json['start_timestamp'],
        context,
        '$jsonPath.start_timestamp',
      ),
      stopTimestamp: ValueParser.asDateTimeUtc(
        json['stop_timestamp'],
        context,
        '$jsonPath.stop_timestamp',
      ),
      nowPlaying: ValueParser.asBool(
          json['now_playing'], context, '$jsonPath.now_playing'),
      hasArchive: ValueParser.asBool(
          json['has_archive'], context, '$jsonPath.has_archive'),
    );
  }
}
