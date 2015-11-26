class User < ActiveRecord::Base

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable, :confirmable,
    :omniauthable, :omniauth_providers => [:facebook, :linkedin]

  belongs_to :role
  has_many :searches
  has_many :subscriptions

  before_create :set_default_role
  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  def is_admin?
    self.role != nil && self.role.name == 'admin'
  end


  def iugu_identifier
    if self[:iugu_identifier] == nil
      customer = Iugu::Customer.create({email: self.email, name: self.name})
      self[:iugu_identifier] = customer.id
      self.save!
    end
    return self[:iugu_identifier]
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def active_subscription
    self.subscriptions.all.bsearch{ |s| s.is_active? }
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end

end
