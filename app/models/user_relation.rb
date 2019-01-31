class UserRelation 
    attr_reader :url, :username
    def initialize(aspects)
        @url = aspects["html_url"]
        @username = aspects["login"]
    end 

    def self.generate(raw_data)
        parsed_data = JSON.parse(raw_data.body)
        parsed_data.map do |relation|
            test = UserRelation.new(relation) 
        end
    end 
end 