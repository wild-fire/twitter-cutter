require 'wukong'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/tweet"

module Normalizers
  module GayoAvello

    class Mapper < Wukong::Streamer::RecordStreamer

      def process time, nickname_and_name, tweet, link
        # and example of nickname and name field is 'GAS137 (Gary Severance)'
        # We strip everything from the parenthesis
        nickname = nickname_and_name.gsub(/\s+\([^\)]+\)/, "")
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
  Normalizers::GayoAvello::Mapper,
  Normalizers::GayoAvello::Reducer
  ).run