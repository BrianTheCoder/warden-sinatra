require 'rubygems'
require 'sinatra/base'
require 'couchrest'
require 'extlib'
require 'faker'
require 'stringex'
require 'ratpack'
require 'bcrypt'
require 'warden'
require 'strategies'

Dir['models/*'].each{|m| require m}
Dir['lib/*'].each{|lib| require lib}