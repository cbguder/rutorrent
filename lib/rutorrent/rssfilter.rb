module RUTorrent
  class RSSFilter
    QUALITIES = %w{HDTV TVRip DVDRip SVCD DSRip DVBRip PDTV HR.HDTV HR.PDTV DVDR
      DVDScr 720p 1080i 1080p WebRip SatRip}

    attr_reader :id, :flags, :name, :filter, :not_filter, :directory, :feed,
      :quality, :label, :postpone_mode, :last_match, :smart_ep_filter,
      :repack_ep_filter, :episode_filter_str, :episode_filter,
      :resolving_candidate

    def initialize(array)
      @id, @flags, @name, @filter, @not_filter, @directory, @feed, @quality,
      @label, @postpone_mode, @last_match, @smart_ep_filter, @repack_ep_filter,
      @episode_filter_str, @episode_filter, @resolving_candidate = array
    end

    def enabled?;               !@flags[0].zero? end
    def matches_original_name?; !@flags[1].zero? end
    def high_priority?;         !@flags[2].zero? end
    def smart_episode_filter?;  !@flags[3].zero? end
    def add_stopped?;           !@flags[4].zero? end

    def qualities
      unless @qualities
        @qualities = []
        QUALITIES.each_with_index do |q,i|
          @qualities << q unless @quality[i].zero?
        end
      end

      @qualities
    end
  end
end
