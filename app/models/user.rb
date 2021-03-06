class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

     # validates :name, presence: true
     after_create :create_customer

   def create_customer
    token = self.stripe_card_token
    plan = self.plan_id
    
    customer = Stripe::Customer.create(
    :card => token,
    :plan => plan,
      :email => self.email
  )         
     end
end
