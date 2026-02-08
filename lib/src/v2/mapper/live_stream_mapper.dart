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
      num: ValueParser.readInt(
        json,
        'num',
        context,
        jsonPath,
      ),
      name: ValueParser.readString(
        json,
        'name',
        context,
        jsonPath,
      ),
      streamType: ValueParser.readString(
        json,
        'stream_type',
        context,
        jsonPath,
      ),
      streamId: ValueParser.readInt(
        json,
        'stream_id',
        context,
        jsonPath,
      ),
      streamIcon: ValueParser.readString(
        json,
        'stream_icon',
        context,
        jsonPath,
      ),
      epgChannelId: ValueParser.readString(
        json,
        'epg_channel_id',
        context,
        jsonPath,
      ),
      added: ValueParser.readDateTimeUtc(
        json,
        'added',
        context,
        jsonPath,
      ),
      customSid: ValueParser.readInt(
        json,
        'custom_sid',
        context,
        jsonPath,
      ),
      tvArchive: ValueParser.readInt(
        json,
        'tv_archive',
        context,
        jsonPath,
      ),
      directSource: ValueParser.readString(
        json,
        'direct_source',
        context,
        jsonPath,
      ),
      tvArchiveDuration: ValueParser.readInt(
        json,
        'tv_archive_duration',
        context,
        jsonPath,
      ),
      categoryId: ValueParser.readInt(
        json,
        'category_id',
        context,
        jsonPath,
      ),
      categoryIds: ValueParser.readIntList(
        json,
        'category_ids',
        context,
        jsonPath,
      ),
      thumbnail: ValueParser.readString(
        json,
        'thumbnail',
        context,
        jsonPath,
      ),
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
