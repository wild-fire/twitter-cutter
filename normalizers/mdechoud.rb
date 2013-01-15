require 'wukong'

module Normalizers
  module MDeChoud

    class Mapper < Wukong::Streamer::RecordStreamer

      # We must parse the Time in the second field and
      # turn it into the number of seconds since the Epoch
      # Then we emit a string with all the fields joined by
      # some bizarre char combination never used in the datasets
      def process twitter_name, time, tweet
        timestamp = Time.parse(time).to_i
        yield [[timestamp, twitter_name, time, tweet].join("~||~"), 1]
      end

    end

    class Reducer < Wukong::Streamer::ListReducer

      # We split the string with the tweet info and raise an
      # exception if there are no 4 fields (this way we test
      # the bizarre char combinaction is actually not used).
      # Then we emit the fields joined by \t
      def finalize
        tweet_fields = key.split("~||~")
        raise ArgumentError.new("Wrong number of tweet fields ") if tweet_fields.length != 4
        yield [ tweet_fields.join("\t"), "" ]
      end

    end

  end
end

Wukong::Script.new(
  Normalizers::MDeChoud::Mapper,
  Normalizers::MDeChoud::Reducer
  ).run