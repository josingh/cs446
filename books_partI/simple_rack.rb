#!/usr/bin/ruby

require 'sqlite3'
require 'rack'
require 'csv'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
    @sort = "id"
    @db = SQLite3::Database.new("books.sqlite3.db")
    @books = @db.execute("select * from books")
    count = 0
	end

	def call(env)
    # create request and response objects
		request = Rack::Request.new(env)
		response = Rack::Response.new
    # include the header
		File.open("header.html", "r") { |head| response.write(head.read) }
		case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/list.*/
        # serve up the list
        render_list(request, response)
      when /\/form.*/
        # serve up a form
        render_form(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
      end	# end case


    File.open("footer.html", "r") { |head| response.write(head.read) }
    case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
      end # end case

      response.finish
    end

  # try http://localhost:8080/list
	def render_list(req, response)
      @sort = req.GET["sort"]
      @books = @db.execute("select * from books order by #{@sort}")
      response.write("<h3>Sorted by: #{@sort}</h3>")
      response.write(ERB.new(File.read("list.html.erb")).result(binding))
	end

  # try http://localhost:8080/form
	def render_form(req, response)
      response.write(ERB.new(File.read("form.html.erb")).result(binding))
	end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
