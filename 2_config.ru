#ONE PAGE RAILS APP
#
#
#We will simply use rubygems to set our load paths
#This mimics the config/boot.rb file
require "rubygems"

#Require our dependencies
#This mimics config/application.rb
require "rails"
require "active_support/railtie"
require "action_controller/railtie"


class SingleFile < Rails::Application
  #Set up production configuration
  config.eager_load    = true
  config.cache_classes = true

  #A key base is required for our app to boot
  config.secret_key_base = "asdflqwioerqwieryoiuwqeyroiuwyqeroiuwqyer"

  routes.append do 
    root to: lambda { |env|
      [200, {"Content-Type" => "text/plain"}, ["Hello World\n"]]
    }
  end
end
SingleFile.initialize!
run Rails.application
