require 'wukong'
require "#{File.dirname(File.expand_path(__FILE__))}/../lib/tweet"

module Normalizers
  module Edinburgh

    class Mapper < Wukong::Streamer::RecordStreamer

      def process time, fake_user_id, tweet, client
        yield [Tweet.serialize({time: time, text: tweet}), 1]
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
  Normalizers::Edinburgh::Mapper,
  Normalizers::Edinburgh::Reducer
  ).run