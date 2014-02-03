## 書き方
# task <タスク名> , [<パラメータ名>, <パラメータ名> ... ] => [<前提タスク名>,<前提タスク名> ... ] do
#    # アクション
# end
def sqlite
  db = SQLite3::Database.new 'database.sqlite3'
  db.results_as_hash = true
  yield db
  db.close
end

task default: :init

# 初期化
task :init do
  require 'sqlite3'
  dbname = 'database.sqlite3'

  if File.exist? dbname
    File.delete dbname
    puts ">> #{dbname}が既に存在したので削除しました"
  end

  puts ">> データベースを作成しています..."

  puts sql = <<-SQL
    CREATE TABLE entries (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      url TEXT NOT NULL,
      thumbnail TEXT,
      icon TEXT,
      users INTEGER NOT NULL,
      description TEXT,
      tags TEXT,
      created INTEGER NOT NULL
    );
  SQL

  begin
    db = SQLite3::Database.new 'database.sqlite3'
    db.results_as_hash = true
    db.execute sql
    db.close
  rescue
    puts ">> データベースの作成に失敗しました"
    exit
  else
    puts ">> #{dbname}を作成しました"
  end
end

task :destroy do
  dbname = 'database.sqlite3'

  if File.exist? dbname
    File.delete dbname
    puts ">> #{dbname}が既に存在したので削除しました"
  end
end

task 'crawl', 'num' do |t, args|
  require 'nokogiri'
  require 'open-uri'
  require 'uri'
  require 'sqlite3'

  sort = %w(hot)
  catagories = %w(it game social)
  number = args[:num].to_i
  count = 0;
  count_new = 0;
  count_updated = 0;

  sort.each do |s|
    catagories.each do |c|
      count_per_catagories = 0;
      catch :loop do
        (number / 20.0).ceil.times do |i|
          page = Nokogiri::HTML(open("http://b.hatena.ne.jp/entrylist/#{c}?sort=#{s}&layout=list&of=#{i * 20}"))
          nodes = page.css('ul.entrylist > li')

          nodes.each do |node|
            if count_per_catagories >= number then throw :loop end

            entry = {
              id: node.attribute('data-eid').text.to_i,
              title: node.css('.entry-link').text,
              url: node.css('.entry-link').attribute('href').text,
              thumbnail: nil,
              users: node.css('.users span').text.to_i,
              description: node.css('.description blockquote').text,
              tags: [],
              created: nil,
              icon: node.css('.domain img').attribute('src').text
            }

            _created = node.css('ul.entry-data li.date').text
            entry[:created] = Time.local(_created[0, 4].to_i, _created[5, 2].to_i, _created[8, 2].to_i, _created[11,2].to_i, _created[14,2].to_i)

            entry[:thumbnail] =
              if _thumb = node.css('.thumbnail img')[0]
                _thumb.attribute('src').text
              else
                nil
              end

            _tags = [c]
            node.css('ul.entry-data > li.tag > a.tag').each do |t|
              _tags << t.text.downcase
            end
            entry[:tags] = _tags.join('/')

            sqlite do |db|
              _exist = false
              db.execute(
                'SELECT COUNT(id) AS count FROM entries WHERE id = ?;',
                [entry[:id].to_i]
              ) do |row|
                _exist = true if row['count'] > 0
              end

              if _exist
                db.execute(
                  'UPDATE entries SET users = ?, tags = ? WHERE id = ?;',
                  [entry[:users], entry[:tags], entry[:id].to_i]
                )

                count += 1
                count_updated += 1
                count_per_catagories += 1
                puts ">> #{count}[upd] #{entry[:title][0, 32]}..."
              else
                db.execute(
                  'INSERT INTO entries(id, title, url, thumbnail, icon, users, description, tags, created) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?);',
                  [entry[:id].to_i, entry[:title], entry[:url], entry[:thumbnail], entry[:icon], entry[:users], entry[:description], entry[:tags], entry[:created].to_i]
                )

                count += 1
                count_new += 1
                count_per_catagories += 1
                puts ">> #{count}[new] #{entry[:title][0,32]}..."
              end
            end
          end
        end
      end
    end
  end

  puts "crawled #{count} items."
  puts "#{count_updated} entries updated."
  puts "#{count_new} new entries added."
end
