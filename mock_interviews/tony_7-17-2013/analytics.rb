class Analytics

  def initialize
    @data = []
    @last_bucket = 0
  end

  def process_page_view(bucket, user_id)
    while bucket != @last_bucket
      @data << 0
      @data.shift

      @last_bucket = (bucket + 1) % 30
    end

    @data.last ||= Hash.new(0)
    @data.last[user_id] += 1
  end

  def get_pageviews_for_user(user_id)
    @data.reduce(:+) { |user_hash| user_hash[user_id] }
  end

  def get_pageviews_for_user_at_bucket(bucket)
    @data[bucket][user_id]
  end

  def get_page_views(bucket)
    @data[29 - (@last_bucket - bucket)]
  end
end

a = Analytics.new
a.process_page_view(0)
a.process_page_view(1)
a.process_page_view(5)
a.process_page_view(31)
a.process_page_view(37)
a.process_page_view(59)
