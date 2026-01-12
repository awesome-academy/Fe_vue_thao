# frozen_string_literal: true

class PostSerializer
  attr_reader :post

  def initialize(post)
    @post = post
  end

  def serialize
    {
      id: post.id,
      title: post.title,
      content: post.content,
      user_id: post.user_id,
      user: user_info,
      created_at: post.created_at,
      updated_at: post.updated_at
    }
  end

  def serialize_without_user
    {
      id: post.id,
      title: post.title,
      content: post.content,
      user_id: post.user_id,
      created_at: post.created_at,
      updated_at: post.updated_at
    }
  end

  def self.serialize(post)
    new(post).serialize
  end

  private

  def user_info
    {
      id: post.user.id,
      name: post.user.name,
      email: post.user.email
    }
  end
end
