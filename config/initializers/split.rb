# Split Gem - for A/B Split testing

#loads split.yml in config so we can customize the redis servers

rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env = ENV['RAILS_ENV'] || 'development'

split_config = YAML.load_file(rails_root + '/config/split.yml')
Split.redis = split_config[rails_env]

# configuration options

Split.configure do |config|
  # config.robot_regex = /my_custom_robot_regex/
  # config.ignore_ip_addresses << '81.19.48.130'
  config.db_failover = true # handle redis errors gracefully
  config.db_failover_on_db_error = proc{|error| Rails.logger.error(error.message) }
  config.allow_multiple_experiments = false
  config.enabled = true
end

# require password to see the dashboard

Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'password'
end