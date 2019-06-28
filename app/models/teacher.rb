class Teacher < ActiveRecord::Base
  has_secure_password
  has_many :repos

  def slug
    username.downcase.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    Teacher.all.find do |teacher|
      teacher.slug == slug
    end
  end
end