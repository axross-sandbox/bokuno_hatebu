helpers do
  def tiny_time(time)
    sabun = Time.now.to_i - time.to_i
    if sabun < 60
      "#{sabun}秒前"
      sabun + '秒前'
    elsif sabun < 3600
      "#{(sabun / 60).floor}分前"
    elsif sabun < 86400
      "#{(sabun / 3600).floor}時間前"
    else
      "#{(sabun / 86400).floor}日前"
    end
  end

  def h(text)
    Rack::Utils.escape_html(text)
  end

  def sqlite
    db = SQLite3::Database.new 'database.sqlite3'
    db.results_as_hash = true
    yield db
    db.close
  end

  def get_entries(tags, populity = 3, limit = 100, offset = 0)
    sql = "SELECT id, title, url, thumbnail, icon, users, description, created FROM entries WHERE users >= #{populity}"

    if tags.is_a?(Array)
      tags.length.times do |i|
        if i == 0
          sql += ' AND (title LIKE ? OR tags LIKE ?'
        elsif i == tags.length - 1
          sql += ' OR title LIKE ? OR tags LIKE ?)'
        else
          sql += ' OR title LIKE ? OR tags LIKE ?'
        end
      end

      prepair = []
      tags.each do |t|
        prepair << "%#{t}%"
        prepair << "%#{t}%"
      end
    elsif tags.is_a?(String) && !tags.empty?
      sql += ' AND tags LIKE ?'
      prepair = ["%#{tags}%"]
    else
      prepair = []
    end

    sql += " ORDER BY id DESC LIMIT #{limit};"
    result = nil

    sqlite do |db|
      result = db.execute(sql, prepair)
    end

    result
  end
end
