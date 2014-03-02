H = { "Content-Type" => "text/plain" }

#map is a rack method
map "/hello" do
  run lambda { |env|
    [220, H, ["WORLD"]]
  }
end


#run is a rack method
#
# Takes an argument that is an object that responds to #call and returns a Rack response.
# The simplest form of this is a lambda object:
#
#   run lambda { |env| [200, { "Content-Type" => "text/plain" }, ["OK"]] }
#
# However this could also be a class:
#
#   class Heartbeat
#     def self.call(env)
#      [200, { "Content-Type" => "text/plain" }, ["OK"]]
#    end
#   end
#
#   run Heartbeat
run lambda { |env|
  [220, H, ["NOthing Here"]]
}
