require 'sinatra'

disable :run, :reload

get '/' do
  'Hello world!'
end
