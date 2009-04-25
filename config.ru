require 'user_management'

use Rack::Session::Cookie
use Warden::Manager do |manager|
  manager.default_strategies :password
  manager.failure_app = UserManagement
end

run UserManagement