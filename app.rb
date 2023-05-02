# frozen_string_literal: true

require 'sinatra'
require_relative 'authenticator'

use Authenticator

set :default_content_type, 'application/json'

get '/api/v1/courses' do
  File.read('response.json')
end
