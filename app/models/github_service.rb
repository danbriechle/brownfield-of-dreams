class GithubService
    def initialize
        
    end 

    def self.connection(token)
        Faraday.new(url: "https://api.github.com") do |f|
            f.headers["Authorization"] = ["token #{token}"]
            f.adapter Faraday.default_adapter
        end 
    end

    def self.repos(user)
        connection(user.token).get "/user/repos"
    end

    def self.user_relation(user, relation)
        connection(user.token).get "/user/#{relation}"
    end 
end 