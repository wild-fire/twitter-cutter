require 'wukong'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/tweet"

module Normalizers
  module Snap

    class Mapper < Wukong::Streamer::RecordStreamer

      def process junk, time, profile_url, tweet
        # We get rid of the http://twitter.com/ part of the url
        nickname = profile_url.gsub("http://twitter.com/", "")
        yield [Tweet.serialize({user_name: nickname, time: time, text: tweet}), 1]
      end

    end

    class Reducer < Wukong::Streamer::ListReducer

      def finalize
        yield [ Tweet.normalize(key), "" ]
      end

    end

  end
end

Wukong::Script.new(
  Normalizers::Snap::Mapper,
  Normalizers::Snap::Reducer
  ).run