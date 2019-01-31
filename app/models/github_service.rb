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
        response = connection(user.token).get "/user/repos"
    end
        
end 