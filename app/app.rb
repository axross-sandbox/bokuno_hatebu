require 'sinatra'
require 'sass'
require 'sqlite3'

# ヘルパーメソッド
require './app/helpers.rb'

# 設定
require './app/settings.rb'

get('/index.css') { scss :index }
get('/index_s.css') { scss :index_s }
get('/favicon.ico') {  }

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

# タグ
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
