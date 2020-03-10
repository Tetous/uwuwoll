json.anime do
  @anime.with_attached_large_poster.with_attached_small_poster.each do |anime|
    json.set! anime.id do
      json.extract! anime, :id, :title, :description, :publisher, :slug
      json.large_poster url_for(anime.large_poster)
      json.small_poster url_for(anime.small_poster)
      json.season_ids anime.season_ids.reverse
      json.episode_ids anime.episode_ids.reverse
      json.episode_count anime.episodes.length
    end
  end
end

json.seasons do
  @anime.each do |anime|
    anime.seasons.each do |season|
      json.set! season.id do
        json.extract! season, :id, :title, :season_num, :anime_id
        json.episode_ids season.episode_ids.reverse
      end
    end
  end
end

json.episodes do
  @anime.each do |anime|
    anime.episodes.with_attached_thumbnail.each do |episode|
      json.set! episode.id do
        json.extract! episode, :id, :title, :description, :episode_num, :season_id, :anime_id, :slug
        # json.thumbnail url_for(episode.thumbnail)
      end
    end
  end
end

json.slugs do
  json.anime do
    @anime.each do |anime|
      json.set! anime.slug do
        json.id anime.id
      end
    end
  end

  json.episodes do
    @anime.each do |anime|
      anime.episodes.each do |episode|
        json.set! episode.slug do
          json.id episode.id
        end
      end
    end
  end
end
