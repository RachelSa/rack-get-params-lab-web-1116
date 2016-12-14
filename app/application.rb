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
  
    elsif req.path.match(/cart/) #if path has cart
      if @@cart.length == 0 #and cart is empty
        resp.write "Your cart is empty" #output "your cart is empty"
      else @@cart.each do |item| #otherwise, for each item, output the item
        resp.write "#{item}\n"
        end
      end
        
    elsif req.path.match(/add/) #if the path has add
          search_term = req.params["item"]  #parse the search term from path
      if @@items.include?(search_term) #if items include that search term
        @@cart << search_term #add the item to the cart
        resp.write "added #{search_term}" #output text
      else 
        resp.write "We don't have that item!" #otherwise, output this text
      end 
    
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
end
