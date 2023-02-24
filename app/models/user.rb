class User < ApplicationRecord
  has_many :projects

  MAX_ADMINS = 1

  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 8 }
  validate :admin_quota, on: :create

  def admin?
    role == 'admin'
  end

  def admin_quota
    return unless admin? && User.where(role: :admin).count >= MAX_ADMINS

    errors.add(:role, 'exceeded maximum number of admins')
  end
end
