class PostsController
  def initialize
    @view = PostsView.new
  end

  ################################################################
  # BEWARE: you MUST NOT use the global variable DB in this file #
  ################################################################

  def index
    all_posts = Post.all
    @view.list_posts(all_posts)
  end

  def create
    post_info = @view.ask_post_info
    Post.new(post_info)
  end

  def update
    post_id = @view.ask_for_id
    post_info = @view.ask_post_info
    post = Post.find(post_id)
    post.title = post_info[:title]
    post.url = post_info[:url]
    post.save
  end

  def destroy
    post_id = @view.ask_for_id
    Post.find(post_id).destroy
  end

  def upvote
    post_id = @view.ask_for_id
    Post.find(post_id).upvote.save
  end
end
