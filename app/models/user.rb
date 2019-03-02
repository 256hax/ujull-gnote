class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  has_many :messages, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one  :users_summary, class_name: 'Users::Summary', dependent: :destroy
end
