require "rubygems"
require "bundler/setup"
require 'goliath'
require 'em-synchrony/activerecord'
require 'grape'
require 'require_all'
require './config/routes'
require_all './app/models'
require_all './app/apis'


class Application < Goliath::API

  def response(env)    
    ::Routes.call(env)    
  end   
  
end