# This class performs de/serialization so we have it centralized
# We could have impelemented it in a more object oriented way but
# it could damage performance (and this is going to be executed
# millions of times)
class Tweet

  @@null_value = "NULL"
  @@fields_count = 6
  @@bizarre_join_char = "~||~"

  # We must parse the Time in the time field and
  # turn it into the number of seconds since the Epoch
  # Then we return a string with all the fields joined by
  # some bizarre char combination never used in the datasets
  def self.serialize tweet

    timestamp = Time.parse(tweet[:time]).to_i
    [
      tweet[:id] || @@null_value,
      timestamp,
      tweet[:time] || @@null_value,
      tweet[:user_id] || @@null_value,
      tweet[:user_name] || @@null_value,
      tweet[:text] || @@null_value,
    ]
     .join(@@bizarre_join_char)

  end

  # We split the string with the tweet info and raise an
  # exception if there are the right number of fields (this way we test
  # the bizarre char combinaction is actually not used).
  # Then we return the fields joined by \t
  def self.normalize serialized_tweet

    fields = serialized_tweet.split(@@bizarre_join_char)
    raise ArgumentError.new("Wrong number of tweet fields ") if fields.length != @@fields_count
    fields.join("\t")

  end

end