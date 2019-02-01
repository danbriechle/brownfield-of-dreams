class GitService

  def self.conn(token, path)
    conn = Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "Token #{token}"
      f.adapter Faraday.default_adapter
    end
    conn.get "/user/#{path}"
  end

end
