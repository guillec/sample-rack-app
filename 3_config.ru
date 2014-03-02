# http://www.confreaks.com/videos/2442-railsconf2013-you-ve-got-a-sinatra-on-your-rails
#
# We will simply use rubygems to set our load paths
require "rubygems"

# Require our dependencies
require "rails"
require "active_support/railtie"
require "action_controller/railtie"

# File expand_path so ugly.....
railsnatra =  File.expand_path("../2_railsnatra", __FILE__)
require railsnatra

class LoggerMiddleware
  def initialize(app, message)
    @app = app
    @message = message
  end

  def call(env)
    p "Request #@message"
    @app.call(env)
  ensure
    p "Response #@message"
  end

end

class Endpoint < Railsnatra
  p "1 Lead Endpoint < Railsnatra"
  use LoggerMiddleware, "3 - railsnatra"

  get "/world" do
    p "About to render.............. "
    render text: "Yeah Railsnatra!\n"
  end
end


class SingleFile < Rails::Application
  p "2 Load SingleFile the Rails APP"


  # Set up production configuration 
  config.eager_load = true
  config.cache_classes = true

  config.middleware.use LoggerMiddleware, "2 - rails app"

  config.secret_key_base = "lkhlhljhljhhlkjhlhhlhklj"

  routes.append do
    p "Mount the Enpoint............... "
    mount Endpoint, at: "/hello"
  end
end

p "Initialie Single File"
SingleFile.initialize!

use LoggerMiddleware, "1 - web server"
p "Run the Rack App"
run Rails.application
