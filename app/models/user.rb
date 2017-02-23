class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"
  validates :email, :first_name, :last_name, :password, presence:true

  self.per_page = 10

  def self.search_by_name(term)
    names_array = term.split(' ')
    if names_array.length == 1
      where('lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{names_array[0].downcase}%","%#{names_array[0].downcase}%").order(:first_name)
    else
      where('lower(first_name) LIKE ? OR lower(last_name) LIKE ? OR lower(first_name) LIKE ? OR lower(last_name) LIKE ?', "%#{names_array[0].downcase}%","%#{names_array[0].downcase}%","%#{names_array[1].downcase}%","%#{names_array[1].downcase}%").order(:first_name)
    end
  end

  def follows_or_same?(athelete)
    if self == athelete || friendships.map(&:friend).include?(athelete)
      return true
    else
      return false
    end
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def current_friendship(friend)
    friendships.where(friend: friend).first
  end
end
