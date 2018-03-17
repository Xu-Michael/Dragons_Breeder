class PostsView
  def list_posts(post_list)
    puts "--------All Posts--------"
    post_list.each do |post|
      puts "#{post.id}. #{post.title}    votes: #{post.votes}"
      puts post.url.to_s
    end
  end

  def ask_for_id
    print "Please input the post ID:\n> "
    gets.chomp.to_i
  end

  def ask_post_info
    print "Please input the post title:\n> "
    title = gets.chomp
    print "Please input the post url:\n> "
    url = gets.chomp
    { title: title, url: url }
  end
end
