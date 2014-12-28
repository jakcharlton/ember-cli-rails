uri = Rails.env.development? ? URI.parse('redis://localhost:6379/') : URI.parse(ENV['REDISCLOUD_URL'])

BabylonApi::Application.config.redis_uri = uri
