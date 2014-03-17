class User < ActiveRecord::Base
  has_many :rand_stats

  def for_api
    {
      created_at: created_at
    }
  end
end