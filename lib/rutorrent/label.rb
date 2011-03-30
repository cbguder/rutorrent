module RUTorrent
  class Label
    attr_reader :label, :torrent_count

    def initialize(array)
      @label, @torrent_count = array
    end
  end
end
