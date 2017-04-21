class CacheManager

  def check_request_rebuild
    if !Rails.root.join('tmp/caching-dev.txt').exist?
      puts ' >>>>>>>>> You need to activate cache by running this command after exiting from console:'
      puts " >>>>>>>>> rails dev:cache"
      puts ' >>>>>>>>> you should get a response'
      puts " >>>>>>>>> Development mode is now being cached."
      return
    end
  total_runs = 0
  cache_for_seconds = 60
    while total_runs < 11 do
      puts "You have Requested at #{Time.now}! this is #{total_runs} run and cache would expire in #{cache_for_seconds} seconds"
       Rails.cache.fetch("slow_job", expires_in: cache_for_seconds.seconds) do
         slow_job
       end
      total_runs += 1
    end
  end
  private

  def slow_job
    requested_at = Time.now.utc.to_i
    expires_at = requested_at + 5
    sleep 5
    puts "Cache Refreshed => your slow request was at #{Time.at(requested_at)} it responded at #{Time.at(expires_at)}!"
  end

  def really_slow_job

  end
end
