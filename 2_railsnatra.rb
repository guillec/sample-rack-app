require "action_controller"
require "action_controller/base"
class Railsnatra < ActionController::Base
  # Declare a class-level attribute whose value is inheritable by subclasses. Subclasses can change their own value and it will not impact parent class.
  p "0 Inside the Railsnatra"
  class_attribute :inline_routes

  # get "/foo" do
  #   ...
  # end
  # 
  # Is stored as:
  #   "GET" => ["/foo", &block]
  #

  self.inline_routes = Hash.new { |h,k| h[k] = [] }

  class << self
    def get(path, &block)
      p "I am get"
      define_route("GET", path, block)
    end

    private
    def define_route(verb, path, block)
      p "I am defining get"
      p "I am getting the inline_routes #{inline_routes}"
      p "What is the verb: #{verb}"
      current = inline_routes[verb] || []
      p "The current value of the routes #{current}"
      p "The path is #{path} and the block is #{block}"
      current += [[path, block]]
      p "To current is now #{current}"
      p "If i merge wa happens #{inline_routes.merge(verb => current)}"
      self.inline_routes = inline_routes.merge(verb => current)
    end
  end


  def self.call(env)
    p "INSIDE THE CALL"
    action(:railsnatra).call(env)
  end

  def railsnatra
    unless run_inline_route
      not_found
    end

    raise "inline route did not redirect nor render" unless performed?
  end

  private

  def run_inline_route
    inline_routes[request.request_method].each do |path, block|
      if request.path_info == path
        instance_exec(&block)
        return true
      end
    end
    false
  end

  def not_found
    p "BUUUUM3j"
    headers["X-Cascade"] = "pass"
    self.response_body = ""
  end
end
