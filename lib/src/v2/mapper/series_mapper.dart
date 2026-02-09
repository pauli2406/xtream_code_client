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
      jsonPath,
    );

    return SeriesItem(
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
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      year: ValueParser.readString(
        json,
        'year',
        context,
        jsonPath,
      ),
      streamType: ValueParser.readString(
        json,
        'stream_type',
        context,
        jsonPath,
      ),
      seriesId: ValueParser.readInt(
        json,
        'series_id',
        context,
        jsonPath,
      ),
      cover: ValueParser.readString(
        json,
        'cover',
        context,
        jsonPath,
      ),
      plot: ValueParser.readString(
        json,
        'plot',
        context,
        jsonPath,
      ),
      cast: ValueParser.readString(
        json,
        'cast',
        context,
        jsonPath,
      ),
      director: ValueParser.readString(
        json,
        'director',
        context,
        jsonPath,
      ),
      genre: ValueParser.readString(
        json,
        'genre',
        context,
        jsonPath,
      ),
      releaseDate: ValueParser.asDateTimeUtc(
          releaseDateRaw, context, '$jsonPath.releaseDate'),
      lastModified: ValueParser.readDateTimeUtc(
        json,
        'last_modified',
        context,
        jsonPath,
      ),
      rating: ValueParser.readDouble(
        json,
        'rating',
        context,
        jsonPath,
      ),
      rating5based: ValueParser.readDouble(
        json,
        'rating_5based',
        context,
        jsonPath,
      ),
      backdropPath: ValueParser.readStringList(
        json,
        'backdrop_path',
        context,
        jsonPath,
      ),
      youtubeTrailer: ValueParser.readString(
        json,
        'youtube_trailer',
        context,
        jsonPath,
      ),
      episodeRunTime: ValueParser.readInt(
        json,
        'episode_run_time',
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
      airDate: ValueParser.readDateTimeUtc(
        json,
        'air_date',
        context,
        jsonPath,
      ),
      episodeCount: ValueParser.readInt(
        json,
        'episode_count',
        context,
        jsonPath,
      ),
      id: ValueParser.readInt(
        json,
        'id',
        context,
        jsonPath,
      ),
      name: ValueParser.readString(
        json,
        'name',
        context,
        jsonPath,
      ),
      overview: ValueParser.readString(
        json,
        'overview',
        context,
        jsonPath,
      ),
      seasonNumber: ValueParser.readInt(
        json,
        'season_number',
        context,
        jsonPath,
      ),
      voteAverage: ValueParser.readDouble(
        json,
        'vote_average',
        context,
        jsonPath,
      ),
      cover: ValueParser.readString(
        json,
        'cover',
        context,
        jsonPath,
      ),
      coverBig: ValueParser.readString(
        json,
        'cover_big',
        context,
        jsonPath,
      ),
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
      jsonPath,
    );

    return SeriesDetails(
      name: ValueParser.readString(
        json,
        'name',
        context,
        jsonPath,
      ),
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      year: ValueParser.readString(
        json,
        'year',
        context,
        jsonPath,
      ),
      cover: ValueParser.readString(
        json,
        'cover',
        context,
        jsonPath,
      ),
      plot: ValueParser.readString(
        json,
        'plot',
        context,
        jsonPath,
      ),
      cast: ValueParser.readString(
        json,
        'cast',
        context,
        jsonPath,
      ),
      director: ValueParser.readString(
        json,
        'director',
        context,
        jsonPath,
      ),
      genre: ValueParser.readString(
        json,
        'genre',
        context,
        jsonPath,
      ),
      releaseDate: ValueParser.asDateTimeUtc(
          releaseDateRaw, context, '$jsonPath.releaseDate'),
      lastModified: ValueParser.readDateTimeUtc(
        json,
        'last_modified',
        context,
        jsonPath,
      ),
      rating: ValueParser.readDouble(
        json,
        'rating',
        context,
        jsonPath,
      ),
      rating5based: ValueParser.readDouble(
        json,
        'rating_5based',
        context,
        jsonPath,
      ),
      backdropPath: ValueParser.readStringList(
        json,
        'backdrop_path',
        context,
        jsonPath,
      ),
      youtubeTrailer: ValueParser.readString(
        json,
        'youtube_trailer',
        context,
        jsonPath,
      ),
      episodeRunTime: ValueParser.readInt(
        json,
        'episode_run_time',
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
      id: ValueParser.readInt(
        json,
        'id',
        context,
        jsonPath,
      ),
      episodeNum: ValueParser.readInt(
        json,
        'episode_num',
        context,
        jsonPath,
      ),
      title: ValueParser.readString(
        json,
        'title',
        context,
        jsonPath,
      ),
      containerExtension: ValueParser.readString(
        json,
        'container_extension',
        context,
        jsonPath,
      ),
      info: _episodeInfo(infoMap, context, '$jsonPath.info'),
      subtitles: ValueParser.readStringList(
        json,
        'subtitles',
        context,
        jsonPath,
      ),
      customSid: ValueParser.readString(
        json,
        'custom_sid',
        context,
        jsonPath,
      ),
      added: ValueParser.readDateTimeUtc(
        json,
        'added',
        context,
        jsonPath,
      ),
      season: ValueParser.readInt(
        json,
        'season',
        context,
        jsonPath,
      ),
      directSource: ValueParser.readString(
        json,
        'direct_source',
        context,
        jsonPath,
      ),
    );
  }

  static EpisodeInfo _episodeInfo(
    Map<String, dynamic> json,
    ParseContext context,
    String jsonPath,
  ) {
    return EpisodeInfo(
      tmdbId: ValueParser.readInt(
        json,
        'tmdb_id',
        context,
        jsonPath,
      ),
      releaseDate: ValueParser.readDateTimeUtc(
        json,
        'release_date',
        context,
        jsonPath,
      ),
      plot: ValueParser.readString(
        json,
        'plot',
        context,
        jsonPath,
      ),
      durationSecs: ValueParser.readInt(
        json,
        'duration_secs',
        context,
        jsonPath,
      ),
      duration: ValueParser.readString(
        json,
        'duration',
        context,
        jsonPath,
      ),
      movieImage: ValueParser.readString(
        json,
        'movie_image',
        context,
        jsonPath,
      ),
      bitrate: ValueParser.readInt(
        json,
        'bitrate',
        context,
        jsonPath,
      ),
      rating: ValueParser.readDouble(
        json,
        'rating',
        context,
        jsonPath,
      ),
      season: ValueParser.readInt(
        json,
        'season',
        context,
        jsonPath,
      ),
      coverBig: ValueParser.readString(
        json,
        'cover_big',
        context,
        jsonPath,
      ),
    );
  }
}
