class AdminUser < ApplicationRecord
  include JobNotifier::Identifier
  identify_job_through(:id, :email)

  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
end
