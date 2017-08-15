class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  has_many :bookings
  has_many :ships # => his own ships
  validates :name, uniqueness: true
  # # ajouter collection pour :species & :planet => seed
  # # validates :species, inclusion: { in: ['Anx', 'Humain', 'Jedi', 'Ewok', 'Droid'], allow_nil: false }
  # # validates :planet, presence: true, inclusion: { in: ['Tatawin', 'Pipada', 'Kamino', 'Dagobah'], allow_nil: false }
  belongs_to :specie, optional: true
  belongs_to :planet, optional: true

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end
end
