module RUTorrent
  class File
    attr_reader :name, :size, :downloaded, :priority

    def initialize(torrent, index, array)
      @torrent = torrent
      @index = index
      @name, @size, @downloaded, @priority = array
    end

    def priority=(value)
      raise 'Invalid priority.' unless (0..3).include?(value)

      @torrent.server.request(:action => 'setprio', :hash => @torrent.hash, :p => value, :f => @index)
      @priority = value
    end
  end
end
