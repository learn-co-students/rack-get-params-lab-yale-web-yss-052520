class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write("Your cart is empty") if @@cart.empty?()
      @@cart.each {|item| resp.write "#{item}\n"}
    elsif req.path.match(/add/)
      search = req.params["item"]
      resp.write(handle_add(search))
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_add(search)
     if !(@@items.include?(search))
        return "We don't have that item"
     else 
      @@cart << search
      return "added #{search}"
     end
  end
end
