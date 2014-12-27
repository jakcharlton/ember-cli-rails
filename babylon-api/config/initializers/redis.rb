# Configuration settings
module Settings
  uri = Rails.env.development? ? URI.parse('redis://localhost:6379/') : URI.parse(ENV['REDISCLOUD_URL'])
  REDIS = Redis.new host: uri.host, port: uri.port, password: uri.password
end
