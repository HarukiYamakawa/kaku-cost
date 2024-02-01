host = ENV["REDIS_HOST"] || "redis"
port = 6379


$redis = Redis.new(host: host, port: 6379)