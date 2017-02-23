class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :exercises, dependent: :destroy

  validates :email, :first_name, :last_name, :password, presence:true

  def full_name
    [first_name, last_name].join(" ")
  end
end
