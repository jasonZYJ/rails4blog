class User < ActiveRecord::Base
  rolify
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable,
    :omniauthable, :omniauth_providers => [:github,:qq_connect, :weibo]
         
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            email = auth.info.email
            user.email = email || user.uid.to_s + "@wilsonblog.com"

            user.password = Devise.friendly_token[0,20]
        end
    end
end
