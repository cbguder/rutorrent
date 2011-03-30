module RUTorrent
  class JobProperties
    attr_reader :hash, :trackers, :ulrate, :dlrate, :superseed, :dht, :pex,
      :seed_override, :seed_ratio, :seed_time, :ulslots

    def initialize(hash)
      @hash          = hash['hash']
      @trackers      = hash['trackers']
      @ulrate        = hash['ulrate']
      @dlrate        = hash['dlrate']
      @superseed     = hash['superseed']
      @dht           = hash['dht']
      @pex           = hash['pex']
      @seed_override = hash['seed_override']
      @seed_ratio    = hash['seed_ratio']
      @seed_time     = hash['seed_time']
      @ulslots       = hash['ulslots']
    end

    def superseed?
      @superseed == 1
    end

    def dht?
      @dht == 1
    end

    def pex?
      @pex == 1
    end

    def seed_override?
      @seed_override == 1
    end

    def seed_ratio
      @seed_ratio / 1000.0
    end

    def trackers
      @trackers.split("\r\n")
    end
  end
end
