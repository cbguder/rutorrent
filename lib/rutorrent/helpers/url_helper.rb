module RUTorrent
  module Helpers
    module URLHelper
      BASE_PATH  = '/gui'
      KEYS = [:token, :list, :cid, :action, :hash, :s, :v, :p, :f]

      def self.path_for(args)
        path = BASE_PATH.dup

        case args
        when String
          path << args
        when Hash
          query = []

          KEYS.each do |key|
            query << "#{key}=#{args[key]}" if args.key?(key)
          end

          path << '/?'
          path << query.join('&')
        end
      end
    end
  end
end
