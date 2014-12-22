uri = if Rails.env.development?
  URI.parse 'redis://redistogo:08f598500f33b32f68cb58f3a60a5414@mummichog.redistogo.com:9233' #'redis://localhost:6379/'
else
  URI.parse  ENV['REDISCLOUD_URL']
end
$redis = Redis.new host: uri.host, port: uri.port, password: uri.password