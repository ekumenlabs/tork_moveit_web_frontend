class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :rememberable, :omniauthable
  devise :invitable,
         :database_authenticatable,
         :recoverable,
         :registerable,
         :trackable,
         :timeoutable,
         :lockable,
         :validatable
end
