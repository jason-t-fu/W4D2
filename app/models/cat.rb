# == Schema Information
#
# Table name: cats
#
#  id          :bigint(8)        not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

COLORS = %w(black brown white calico)

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper
  validates :birth_date, :name, :description, presence: true
  validates :sex, 
                presence: true, 
                inclusion: { in: %w(m f), message: "%{value} is not a valid sex" }
  validates :color, 
                presence: true, 
                inclusion: { in: COLORS, message: "%{value} is not a valid color" }
  
  has_many :rental_requests,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def self.colors
    COLORS
  end
  
  def age
    time_ago_in_words(birth_date)
  end


end
