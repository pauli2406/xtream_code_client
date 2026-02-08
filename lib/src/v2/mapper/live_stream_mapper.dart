import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/model/live_stream_item.dart';

class LiveStreamMapper {
  static LiveStreamItem fromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return LiveStreamItem(
      num: ValueParser.asInt(json['num'], context, '$jsonPath.num'),
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      streamType: ValueParser.asString(
          json['stream_type'], context, '$jsonPath.stream_type'),
      streamId:
          ValueParser.asInt(json['stream_id'], context, '$jsonPath.stream_id'),
      streamIcon: ValueParser.asString(
          json['stream_icon'], context, '$jsonPath.stream_icon'),
      epgChannelId: ValueParser.asString(
        json['epg_channel_id'],
        context,
        '$jsonPath.epg_channel_id',
      ),
      added:
          ValueParser.asDateTimeUtc(json['added'], context, '$jsonPath.added'),
      customSid: ValueParser.asInt(
          json['custom_sid'], context, '$jsonPath.custom_sid'),
      tvArchive: ValueParser.asInt(
          json['tv_archive'], context, '$jsonPath.tv_archive'),
      directSource: ValueParser.asString(
        json['direct_source'],
        context,
        '$jsonPath.direct_source',
      ),
      tvArchiveDuration: ValueParser.asInt(
        json['tv_archive_duration'],
        context,
        '$jsonPath.tv_archive_duration',
      ),
      categoryId: ValueParser.asInt(
          json['category_id'], context, '$jsonPath.category_id'),
      categoryIds: ValueParser.asIntList(
          json['category_ids'], context, '$jsonPath.category_ids'),
      thumbnail: ValueParser.asString(
          json['thumbnail'], context, '$jsonPath.thumbnail'),
    );
  }

  static List<LiveStreamItem> fromList(
    List<Map<String, dynamic>> items,
    ParseContext context,
    String jsonPath,
  ) {
    final result = <LiveStreamItem>[];
    for (var index = 0; index < items.length; index++) {
      result.add(fromMap(items[index], context, '$jsonPath[$index]'));
    }
    return result;
  }
}
