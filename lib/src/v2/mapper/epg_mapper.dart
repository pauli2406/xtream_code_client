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
      jsonPath,
    );
    final stopRaw = json['stop'] ?? json['end'] ?? json['stop_timestamp'];

    return EpgListing(
      id: ValueParser.readInt(
        json,
        'id',
        context,
        jsonPath,
      ),
      epgId: ValueParser.readInt(
        json,
        'epg_id',
        context,
        jsonPath,
      ),
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      lang: ValueParser.readString(
        json,
        'lang',
        context,
        jsonPath,
      ),
      start: ValueParser.readDateTimeUtc(
        json,
        'start',
        context,
        jsonPath,
      ),
      end: ValueParser.asDateTimeUtc(endRaw, context, '$jsonPath.end'),
      description: ValueParser.readString(
        json,
        'description',
        context,
        jsonPath,
      ),
      channelId: ValueParser.readString(
        json,
        'channel_id',
        context,
        jsonPath,
      ),
      startTimestamp: ValueParser.readDateTimeUtc(
        json,
        'start_timestamp',
        context,
        jsonPath,
      ),
      stopTimestamp: ValueParser.readDateTimeUtc(
        json,
        'stop_timestamp',
        context,
        jsonPath,
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
      jsonPath,
    );

    return EpgTableListing(
      id: ValueParser.readInt(
        json,
        'id',
        context,
        jsonPath,
      ),
      epgId: ValueParser.readInt(
        json,
        'epg_id',
        context,
        jsonPath,
      ),
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      lang: ValueParser.readString(
        json,
        'lang',
        context,
        jsonPath,
      ),
      start: ValueParser.readDateTimeUtc(
        json,
        'start',
        context,
        jsonPath,
      ),
      end: ValueParser.asDateTimeUtc(endRaw, context, '$jsonPath.end'),
      description: ValueParser.readString(
        json,
        'description',
        context,
        jsonPath,
      ),
      channelId: ValueParser.readString(
        json,
        'channel_id',
        context,
        jsonPath,
      ),
      startTimestamp: ValueParser.readDateTimeUtc(
        json,
        'start_timestamp',
        context,
        jsonPath,
      ),
      stopTimestamp: ValueParser.readDateTimeUtc(
        json,
        'stop_timestamp',
        context,
        jsonPath,
      ),
      nowPlaying: ValueParser.readBool(
        json,
        'now_playing',
        context,
        jsonPath,
      ),
      hasArchive: ValueParser.readBool(
        json,
        'has_archive',
        context,
        jsonPath,
      ),
    );
  }
}
