class BookmarkFacade
  def initialize(user)
    @user = user
  end

  def bookmarks
    current_user.tutorials.includes(:videos)
  end
end
