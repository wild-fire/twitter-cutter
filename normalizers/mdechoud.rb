require 'wukong'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/tweet"

module Normalizers
  module MDeChoud

    class Mapper < Wukong::Streamer::RecordStreamer

      def process user_name, time, tweet
        yield [Tweet.serialize({user_name: user_name, time: time, text: tweet}), 1]
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
  Normalizers::MDeChoud::Mapper,
  Normalizers::MDeChoud::Reducer
  ).run