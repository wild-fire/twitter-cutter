require 'wukong'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/tweet"
require "oj"

module Normalizers
  module OConnor

    class Mapper < Wukong::Streamer::LineStreamer

      def process json_tweet
        tweet = Oj.load json_tweet
        yield [Tweet.serialize({id: tweet["id"], user_id: tweet["user"]["id"], user_name: tweet["user"]["screen_name"], time: tweet["created_at"], text: tweet["text"].gsub("\n", " ")}), 1]
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
  Normalizers::OConnor::Mapper,
  Normalizers::OConnor::Reducer
  ).run