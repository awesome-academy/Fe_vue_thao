# frozen_string_literal: true

class PostService
  # Create a new post
  # @param user [User] user instance
  # @param params [Hash] post parameters
  # @return [Result::Success, Result::Failure]
  def create(user, params)
    post = user.posts.build(params)

    if post.save
      Result.success(post)
    else
      Result.failure(post.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Update post
  # @param post [Post] post instance
  # @param params [Hash] post parameters to update
  # @return [Result::Success, Result::Failure]
  def update(post, params)
    if post.update(params)
      Result.success(post)
    else
      Result.failure(post.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end

  # Delete post
  # @param post [Post] post instance
  # @return [Result::Success, Result::Failure]
  def delete(post)
    if post.destroy
      Result.success({ message: 'Post deleted successfully' })
    else
      Result.failure(post.errors.messages)
    end
  rescue StandardError => e
    Result.failure({ error: e.message })
  end
end
