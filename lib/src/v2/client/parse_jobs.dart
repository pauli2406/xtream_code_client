import 'package:xtream_code_client/src/epg_parser.dart';
import 'package:xtream_code_client/src/model/epg/epg.dart' show EPG;
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/parse_warning.dart';
import 'package:xtream_code_client/src/v2/core/parser_options.dart';
import 'package:xtream_code_client/src/v2/mapper/category_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/epg_lite_parser.dart';
import 'package:xtream_code_client/src/v2/mapper/epg_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/general_information_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/live_stream_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/series_mapper.dart';
import 'package:xtream_code_client/src/v2/mapper/vod_mapper.dart';
import 'package:xtream_code_client/src/v2/model/category.dart';
import 'package:xtream_code_client/src/v2/model/channel_epg.dart';
import 'package:xtream_code_client/src/v2/model/channel_epg_table.dart';
import 'package:xtream_code_client/src/v2/model/epg_lite.dart';
import 'package:xtream_code_client/src/v2/model/general_information.dart';
import 'package:xtream_code_client/src/v2/model/live_stream_item.dart';
import 'package:xtream_code_client/src/v2/model/series_info.dart';
import 'package:xtream_code_client/src/v2/model/series_item.dart';
import 'package:xtream_code_client/src/v2/model/vod_info.dart';
import 'package:xtream_code_client/src/v2/model/vod_item.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

class JsonParseRequest {
  const JsonParseRequest({
    required this.body,
    required this.mode,
  });

  final String body;
  final ParseMode mode;
}

class JsonParseResult<T> {
  const JsonParseResult({
    required this.data,
    required this.warnings,
  });

  final T data;
  final List<ParseWarning> warnings;
}

JsonParseResult<GeneralInformation> parseGeneralInformation(
    JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final root = ResponseNormalizer.expectObject(payload, context, r'$');
      return GeneralInformationMapper.fromMap(root, context, r'$');
    },
  );
}

JsonParseResult<List<Category>> parseCategoryList(JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final rows = ResponseNormalizer.expectObjectList(payload, context, r'$');
      return CategoryMapper.fromList(rows, context, r'$');
    },
  );
}

JsonParseResult<List<LiveStreamItem>> parseLiveStreamItems(
    JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final rows = ResponseNormalizer.expectObjectList(payload, context, r'$');
      return LiveStreamMapper.fromList(rows, context, r'$');
    },
  );
}

JsonParseResult<List<VodItem>> parseVodItems(JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final rows = ResponseNormalizer.expectObjectList(payload, context, r'$');
      return VodMapper.itemsFromList(rows, context, r'$');
    },
  );
}

JsonParseResult<VodInfo> parseVodInfo(JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final root = ResponseNormalizer.expectObject(payload, context, r'$');
      return VodMapper.infoFromMap(root, context, r'$');
    },
  );
}

JsonParseResult<List<SeriesItem>> parseSeriesItems(JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final rows = ResponseNormalizer.expectObjectList(payload, context, r'$');
      return SeriesMapper.itemsFromList(rows, context, r'$');
    },
  );
}

JsonParseResult<SeriesInfo> parseSeriesInfo(JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final root = ResponseNormalizer.expectObject(payload, context, r'$');
      return SeriesMapper.infoFromMap(root, context, r'$');
    },
  );
}

JsonParseResult<ChannelEpg> parseChannelEpg(JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final root = ResponseNormalizer.expectObject(payload, context, r'$');
      return EpgMapper.channelEpgFromMap(root, context, r'$');
    },
  );
}

JsonParseResult<ChannelEpgTable> parseChannelEpgTable(
    JsonParseRequest request) {
  return _parse(
    request,
    (payload, context) {
      final root = ResponseNormalizer.expectObject(payload, context, r'$');
      return EpgMapper.channelEpgTableFromMap(root, context, r'$');
    },
  );
}

EPG parseFullEpg(String xml) {
  final parser = EpgParser();
  return parser.parse(xml);
}

EpgLite parseLiteEpg(String xml) {
  final parser = EpgLiteParser();
  return parser.parse(xml);
}

JsonParseResult<T> _parse<T>(
  JsonParseRequest request,
  T Function(dynamic payload, ParseContext context) mapper,
) {
  final context = ParseContext(
    options: ParserOptions(mode: request.mode),
  );
  final payload =
      ResponseNormalizer.decodeJsonBody(request.body, context, r'$');
  final data = mapper(payload, context);
  return JsonParseResult(
    data: data,
    warnings: List<ParseWarning>.from(context.warnings),
  );
}
