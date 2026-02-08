import 'package:xtream_code_client/src/v2/core/field_aliases.dart';
import 'package:xtream_code_client/src/v2/core/parse_context.dart';
import 'package:xtream_code_client/src/v2/core/value_parser.dart';
import 'package:xtream_code_client/src/v2/model/series_info.dart';
import 'package:xtream_code_client/src/v2/model/series_item.dart';
import 'package:xtream_code_client/src/v2/normalizer/response_normalizer.dart';

class SeriesMapper {
  static SeriesItem itemFromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final releaseDateRaw = FieldAliases.resolve(
      json,
      <String>['release_date', 'releaseDate', 'releasedate'],
      context,
      '$jsonPath.releaseDate',
    );

    return SeriesItem(
      num: ValueParser.asInt(json['num'], context, '$jsonPath.num'),
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      year: ValueParser.asString(json['year'], context, '$jsonPath.year'),
      streamType: ValueParser.asString(
          json['stream_type'], context, '$jsonPath.stream_type'),
      seriesId:
          ValueParser.asInt(json['series_id'], context, '$jsonPath.series_id'),
      cover: ValueParser.asString(json['cover'], context, '$jsonPath.cover'),
      plot: ValueParser.asString(json['plot'], context, '$jsonPath.plot'),
      cast: ValueParser.asString(json['cast'], context, '$jsonPath.cast'),
      director:
          ValueParser.asString(json['director'], context, '$jsonPath.director'),
      genre: ValueParser.asString(json['genre'], context, '$jsonPath.genre'),
      releaseDate: ValueParser.asDateTimeUtc(
          releaseDateRaw, context, '$jsonPath.releaseDate'),
      lastModified: ValueParser.asDateTimeUtc(
        json['last_modified'],
        context,
        '$jsonPath.last_modified',
      ),
      rating: ValueParser.asDouble(json['rating'], context, '$jsonPath.rating'),
      rating5based: ValueParser.asDouble(
        json['rating_5based'],
        context,
        '$jsonPath.rating_5based',
      ),
      backdropPath: ValueParser.asStringList(
        json['backdrop_path'],
        context,
        '$jsonPath.backdrop_path',
      ),
      youtubeTrailer: ValueParser.asString(
        json['youtube_trailer'],
        context,
        '$jsonPath.youtube_trailer',
      ),
      episodeRunTime: ValueParser.asInt(
        json['episode_run_time'],
        context,
        '$jsonPath.episode_run_time',
      ),
      categoryId: ValueParser.asInt(
          json['category_id'], context, '$jsonPath.category_id'),
      categoryIds: ValueParser.asIntList(
          json['category_ids'], context, '$jsonPath.category_ids'),
    );
  }

  static List<SeriesItem> itemsFromList(
    List<Map<String, dynamic>> items,
    ParseContext context,
    String jsonPath,
  ) {
    final result = <SeriesItem>[];
    for (var index = 0; index < items.length; index++) {
      result.add(itemFromMap(items[index], context, '$jsonPath[$index]'));
    }
    return result;
  }

  static SeriesInfo infoFromMap(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    // We intentionally parse explicitly to keep warning paths tight.
    final seasonList = ResponseNormalizer.expectObjectList(
      json['seasons'],
      context,
      '$jsonPath.seasons',
    );

    final parsedSeasons = <Season>[];
    for (var index = 0; index < seasonList.length; index++) {
      parsedSeasons.add(
          _season(seasonList[index], context, '$jsonPath.seasons[$index]'));
    }

    final infoMap =
        ResponseNormalizer.readObjectField(json, 'info', context, jsonPath);
    final info = _seriesDetails(infoMap, context, '$jsonPath.info');

    final episodesRaw =
        ValueParser.asMap(json['episodes'], context, '$jsonPath.episodes');
    final episodes = <String, List<Episode>>{};
    if (episodesRaw != null) {
      for (final entry in episodesRaw.entries) {
        final seasonKey = entry.key;
        final episodeItems = ResponseNormalizer.expectObjectList(
          entry.value,
          context,
          '$jsonPath.episodes.$seasonKey',
        );
        final parsedEpisodes = <Episode>[];
        for (var index = 0; index < episodeItems.length; index++) {
          parsedEpisodes.add(
            _episode(
              episodeItems[index],
              context,
              '$jsonPath.episodes.$seasonKey[$index]',
            ),
          );
        }
        episodes[seasonKey] = parsedEpisodes;
      }
    }

    return SeriesInfo(
      seasons: parsedSeasons,
      info: info,
      episodes: episodes,
    );
  }

  static Season _season(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return Season(
      airDate: ValueParser.asDateTimeUtc(
          json['air_date'], context, '$jsonPath.air_date'),
      episodeCount: ValueParser.asInt(
          json['episode_count'], context, '$jsonPath.episode_count'),
      id: ValueParser.asInt(json['id'], context, '$jsonPath.id'),
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      overview:
          ValueParser.asString(json['overview'], context, '$jsonPath.overview'),
      seasonNumber: ValueParser.asInt(
          json['season_number'], context, '$jsonPath.season_number'),
      voteAverage: ValueParser.asDouble(
          json['vote_average'], context, '$jsonPath.vote_average'),
      cover: ValueParser.asString(json['cover'], context, '$jsonPath.cover'),
      coverBig: ValueParser.asString(
          json['cover_big'], context, '$jsonPath.cover_big'),
    );
  }

  static SeriesDetails _seriesDetails(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final releaseDateRaw = FieldAliases.resolve(
      json,
      <String>['release_date', 'releaseDate', 'releasedate'],
      context,
      '$jsonPath.releaseDate',
    );

    return SeriesDetails(
      name: ValueParser.asString(json['name'], context, '$jsonPath.name'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      year: ValueParser.asString(json['year'], context, '$jsonPath.year'),
      cover: ValueParser.asString(json['cover'], context, '$jsonPath.cover'),
      plot: ValueParser.asString(json['plot'], context, '$jsonPath.plot'),
      cast: ValueParser.asString(json['cast'], context, '$jsonPath.cast'),
      director:
          ValueParser.asString(json['director'], context, '$jsonPath.director'),
      genre: ValueParser.asString(json['genre'], context, '$jsonPath.genre'),
      releaseDate: ValueParser.asDateTimeUtc(
          releaseDateRaw, context, '$jsonPath.releaseDate'),
      lastModified: ValueParser.asDateTimeUtc(
        json['last_modified'],
        context,
        '$jsonPath.last_modified',
      ),
      rating: ValueParser.asDouble(json['rating'], context, '$jsonPath.rating'),
      rating5based: ValueParser.asDouble(
        json['rating_5based'],
        context,
        '$jsonPath.rating_5based',
      ),
      backdropPath: ValueParser.asStringList(
        json['backdrop_path'],
        context,
        '$jsonPath.backdrop_path',
      ),
      youtubeTrailer: ValueParser.asString(
        json['youtube_trailer'],
        context,
        '$jsonPath.youtube_trailer',
      ),
      episodeRunTime: ValueParser.asInt(
        json['episode_run_time'],
        context,
        '$jsonPath.episode_run_time',
      ),
      categoryId: ValueParser.asInt(
          json['category_id'], context, '$jsonPath.category_id'),
      categoryIds: ValueParser.asIntList(
          json['category_ids'], context, '$jsonPath.category_ids'),
    );
  }

  static Episode _episode(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    final infoMap =
        ValueParser.asMap(json['info'], context, '$jsonPath.info') ??
            <String, dynamic>{};

    return Episode(
      id: ValueParser.asInt(json['id'], context, '$jsonPath.id'),
      episodeNum: ValueParser.asInt(
          json['episode_num'], context, '$jsonPath.episode_num'),
      title: ValueParser.asString(json['title'], context, '$jsonPath.title'),
      containerExtension: ValueParser.asString(
        json['container_extension'],
        context,
        '$jsonPath.container_extension',
      ),
      info: _episodeInfo(infoMap, context, '$jsonPath.info'),
      subtitles: ValueParser.asStringList(
          json['subtitles'], context, '$jsonPath.subtitles'),
      customSid: ValueParser.asString(
          json['custom_sid'], context, '$jsonPath.custom_sid'),
      added:
          ValueParser.asDateTimeUtc(json['added'], context, '$jsonPath.added'),
      season: ValueParser.asInt(json['season'], context, '$jsonPath.season'),
      directSource: ValueParser.asString(
          json['direct_source'], context, '$jsonPath.direct_source'),
    );
  }

  static EpisodeInfo _episodeInfo(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return EpisodeInfo(
      tmdbId: ValueParser.asInt(json['tmdb_id'], context, '$jsonPath.tmdb_id'),
      releaseDate: ValueParser.asDateTimeUtc(
        json['release_date'],
        context,
        '$jsonPath.release_date',
      ),
      plot: ValueParser.asString(json['plot'], context, '$jsonPath.plot'),
      durationSecs: ValueParser.asInt(
          json['duration_secs'], context, '$jsonPath.duration_secs'),
      duration:
          ValueParser.asString(json['duration'], context, '$jsonPath.duration'),
      movieImage: ValueParser.asString(
          json['movie_image'], context, '$jsonPath.movie_image'),
      bitrate: ValueParser.asInt(json['bitrate'], context, '$jsonPath.bitrate'),
      rating: ValueParser.asDouble(json['rating'], context, '$jsonPath.rating'),
      season: ValueParser.asInt(json['season'], context, '$jsonPath.season'),
      coverBig: ValueParser.asString(
          json['cover_big'], context, '$jsonPath.cover_big'),
    );
  }
}
