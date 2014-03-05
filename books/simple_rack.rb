#!/usr/bin/ruby

require 'rack'
require 'csv'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
		@books = []
    @sort = "Rank"
    count = 0
    f = File.open("books.csv", "r")
    f.readlines.each {|e|
      e.chomp!
      b = e.split(",")
      b.unshift(count)
      @books.push(b)
      count = count + 1
    }
    f.close
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
    @sort = req.GET['sort']
    if(@sort.eql?"Rank")
      @books = @books.sort {|a, b| a[0] <=> b[0]}
    end
    if(@sort.eql?"Title")
      @books = @books.sort {|a, b| a[1] <=> b[1]}
    end
    if(@sort.eql?"Author")
      @books = @books.sort {|a, b| a[2] <=> b[2]}
    end
     if(@sort.eql?"Language")
      @books = @books.sort {|a, b| a[3] <=> b[3]}
    end
    if(@sort.eql?"Year")
      @books = @books.sort {|a, b| a[4] <=> b[4]}
    end
    if(@sort.eql?"Copies")
      @books = @books.sort {|a, b| a[5] <=> b[5]}
    end
    response.write("<h2>Sorted by #{@sort}</h2>")
    response.write("<table border = '1' style = 'width:1000px'>")
    response.write("<th>Rank</th>")
    response.write("<th>Title</th>")
    response.write("<th>Author</th>")
    response.write("<th>Language</th>")
    response.write("<th>Year</th>")
    response.write("<th>Copies</th>")
		@books.each{|book|
      response.write("<tr><td>#{book[0]}</td><td>#{book[1]}</td><td>#{book[2]}</td><td>#{book[3]}</td><td>#{book[4]}</td><td>#{book[5]}</td></tr>")
    }
    response.write("</table>")
	end

  # try http://localhost:8080/form
	def render_form(req, response)
		response.write( "<form action='/list' method='get'>" )
    response.write("<select name='sort'>")
    response.write("<option value='Rank'>Rank</option>")
    response.write("<option value='Title'>Title</option>")
    response.write("<option value='Author'>Author</option>")
    response.write("<option value='Language'>Language</option>")
    response.write("<option value='Year'>Year</option>")
    response.write("<option value='Copies'>Copies</option>")
    response.write("</select>")
    response.write("<input type='submit' value='Display List'>")
    response.write("</form>")

	end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
