module RUTorrent
  class Settings
    def initialize(server)
      @server = server
      @settings = nil
      @dirty = false
    end

    def reload
      json = @server.request(:action => 'getsettings')
      @settings = Hash[json['settings'].map{|s| [s[0], s[2]] }]
      @dirty = false
    end

    def [](key)
      reload_if_necessary
      @settings[key]
    end

    def []=(key, value)
      @server.request(:action => 'setsetting', :s => key, :v => value)
      @dirty = true
    end

    def to_hash
      reload_if_necessary
      @settings.dup
    end

  private

    def reload_if_necessary
      reload if @dirty or @settings.nil?
    end
  end
end
