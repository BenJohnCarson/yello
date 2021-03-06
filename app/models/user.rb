class User < ActiveRecord::Base
  has_many :restaurants
  has_many :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  def self.from_omniauth(auth)
    where(providers: auth.providers, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.user_name = auth.info.name   # assuming the user model has a name
      #   user.image = auth.info.image # assuming the user model has an image
      #   # If you are using confirmable and the provider(s) you use validate emails,
      #   # uncomment the line below to skip the confirmation emails.
      #user.skip_confirmation!
    end
  end

  def self.new_with_session(params,session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?

      end
    end
  end
  validates_presence_of :user_name

  devise :database_authenticatable, :registerable, :omniauthable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauth_providers => [:facebook]
end
