class BookmarkFacade
  attr_reader :bookmarks
  def initialize(user)
    @user = user
  end

  def bookmarks
    @user.tutorials.includes(:videos)
  end
end
