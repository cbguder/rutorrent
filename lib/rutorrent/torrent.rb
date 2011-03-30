module RUTorrent
  class Torrent
    attr_reader :hash, :status, :name, :size, :progress, :downloaded, :uploaded,
      :ratio, :upload_speed, :download_speed, :eta, :label, :peers_connected,
      :peers_in_swarm, :seeds_connected, :seeds_in_swarm, :availability,
      :torrent_queue_order, :remaining

    attr_reader :server

    def initialize(server, array)
      @server = server

      @hash, @status, @name, @size, @progress, @downloaded, @uploaded, @ratio,
      @upload_speed, @download_speed, @eta, @label, @peers_connected,
      @peers_in_swarm, @seeds_connected, @seeds_in_swarm, @availability,
      @torrent_queue_order, @remaining = array
    end

    def files
      load_files unless @files
      @files
    end

    def progress
      @progress / 1000.0
    end

    def ratio
      @ratio / 1000.0
    end

    def availability
      @availability / 65536.0
    end

    def properties
      load_properties unless @properties
      @properties
    end

    def start;       perform 'start'       end
    def stop;        perform 'stop'        end
    def pause;       perform 'pause'       end
    def unpause;     perform 'unpause'     end
    def forcestart;  perform 'forcestart'  end
    def recheck;     perform 'recheck'     end
    def remove;      perform 'remove'      end
    def removedata;  perform 'removedata'  end
    def queuebottom; perform 'queuebottom' end
    def queuedown;   perform 'queuedown'   end
    def queuetop;    perform 'queuetop'    end
    def queueup;     perform 'queueup'     end

    def started?;           !@status[0].zero? end
    def checking?;          !@status[1].zero? end
    def start_after_check?; !@status[2].zero? end
    def checked?;           !@status[3].zero? end
    def error?;             !@status[4].zero? end
    def paused?;            !@status[5].zero? end
    def queued?;            !@status[6].zero? end
    def loaded?;            !@status[7].zero? end

    def inspect
      '#<%s:0x%8x %s>' % [self.class, object_id * 2, @name]
    end

  private

    def load_files
      json = @server.request(:action => 'getfiles', :hash => @hash)

      @files = []
      json['files'][1].each_with_index do |file,i|
        @files << RUTorrent::File.new(@torrent, i, file)
      end
    end

    def load_properties
      json = @server.request(:action => 'getprops', :hash => @hash)
      @properties = RUTorrent::JobProperties.new(json['props'][0])
    end

    def perform(action)
      @server.request(:action => action, :hash => @hash)
    end
  end
end
