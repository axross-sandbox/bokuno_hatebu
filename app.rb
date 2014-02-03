require 'sinatra'
require 'sass'
require 'sqlite3'
require './model'
require './setting'

get '/index.css' do
  scss :index
end

get '/index_s.css' do
  scss :index_s
end

get '/favicon.ico' do
  # 未定
end

# トップページ
get '/' do
  tags = []
  RESERVED_TAGS.each do |t|
    tags.concat(t[:tags]) if t[:tags].is_a?(Array)
  end

  if /(iPhone|Android|iPod).+Mobile/ === request.user_agent
    @entries = get_entries(tags, 10, 50)
    erb :index_s
  else
    @entries = get_entries(tags, 10, 100)
    erb :index
  end
end

get '/:tag' do |tag|
  tags = [tag, tag]
  populity = 1

  RESERVED_TAGS.each do |t|
    if tag == t[:url]
      tags = t[:tags]
      populity = t[:populity] ? t[:populity] : 5
    end
  end

  if /(iPhone|Android|iPod).+Mobile/ === request.user_agent
    @tag = tag
    @entries = get_entries(tags, populity, 50)
    erb :index_s
  else
    @entries = get_entries(tags, populity, 100)
    erb :index
  end
end
