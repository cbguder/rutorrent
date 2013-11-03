require 'rubygems'
require 'nokogiri'
require 'net/http'
require 'json'

module RUTorrent
  class Server
    TOKEN_PATH = '/gui/token.html'

    attr_reader :host, :port, :user, :cookie, :token, :build

    def initialize(host, port, user, pass)
      @host = host
      @port = port
      @user = user
      @pass = pass

      @cookie = ''
      @token  = nil
      @build  = nil

      @http = Net::HTTP.new(@host, @port)

      get_token
    end

    def settings
        @settings ||= RUTorrent::Settings.new(self)
    end

    def labels
      reload unless @labels
      @labels
    end

    def torrents
      reload unless @torrents
      @torrents
    end

    def rssfilters
      reload unless @rssfilters
      @rssfilters
    end

    def request(args)
      args[:token] ||= @token if @token

      path = RUTorrent::Helpers::URLHelper.path_for(args)
      resp = request_raw(path)

      begin
        json = JSON.parse(resp.body)
        @build = json['build'] if json.has_key?('build')
        ret = json
      rescue
        ret = resp.body
      end

      ret
    end

    def reload
      json = request(:list => 1)

      @labels = []
      json['label'].each do |label|
        @labels << Label.new(label)
      end

      @torrents = []
      json['torrents'].each do |torrent|
        @torrents << Torrent.new(self, torrent)
      end

      @rssfilters = []
      json['rssfilters'].each do |rssfilter|
        @rssfilters << RSSFilter.new(rssfilter)
      end
    end

    def inspect
      '#<%s:0x%8x %s@%s:%s>' % [self.class, object_id * 2, @user, @host, @port]
    end

  private

    def request_raw(path, authenticate=true)
      req = Net::HTTP::Get.new(path, {"Cookie" => @cookie})
      req.basic_auth @user, @pass if authenticate
      @http.request(req)
    end

    def get_token
      response = request_raw(TOKEN_PATH, false)

      if response.code != '401' or response['WWW-Authenticate'] != 'Basic realm="uTorrent"'
        raise "#{@host} is not a valid uTorrent server."
      end

      response = request_raw(TOKEN_PATH)

      @cookie = response['Set-Cookie'][/(.*?);/]

      html = Nokogiri::HTML.parse(response.body)
      @token = html.css("#token").text
    end
  end
end
