require 'wukong'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/tweet"

module Normalizers
  module CIKM2010

    class Mapper < Wukong::Streamer::RecordStreamer

      def process user_id, tweet_id, tweet, time
        yield [Tweet.serialize({user_id: user_id, time: time, text: tweet, id: tweet_id}), 1]
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
  Normalizers::CIKM2010::Mapper,
  Normalizers::CIKM2010::Reducer
  ).run