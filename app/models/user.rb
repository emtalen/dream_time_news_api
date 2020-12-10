# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  after_initialize :set_default_role, if: :new_record?

  enum role: [:visitor, :registered_user, :journalist]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  private 

  def set_default_role
    self.role ||= :visitor
  end
end
