module Sinatra
  module Obc
    def fake_paragraph(size = 9)
      tag(:p,Faker::Lorem.paragraph(size))
    end
    
    def view(template)
      erb :"#{self.class.to_s.snake_case}/#{template}"
    end
    
    def logged_in?
      env['warden'].authenticated?
    end
  end # AustinEats

  helpers Obc
end # Sinatra