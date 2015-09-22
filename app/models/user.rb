class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :role
  has_many :searches
  before_create :set_default_role

  def is_admin?
  	self.role == 'admin'
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end

end
