# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint(8)        not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, 
          presence: true,
          inclusion: { in: %w(PENDING APPROVED DENIED), message: "%{value} is not a valid status" }
  validate :does_not_overlap_approved_request

  belongs_to :cat,
    foreign_key: :cat_id,
    class_name: :Cat

  def overlapping_requests
    CatRentalRequest.select(:id, :cat_id, :status, :start_date, :end_date)
      .where(cat_id: "#{self.cat_id}")
      .where.not(id: "#{self.id}")
      .where('(start_date BETWEEN ? AND ?) OR (end_date BETWEEN ? AND ?)', 
              "#{self.start_date}", "#{self.end_date}", "#{self.start_date}", "#{self.end_date}")
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors.add("rental dates are taken")
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def approve!
    if does_not_overlap_approved_request
      CatRentalRequest.transaction do
        self.update(status: 'APPROVED')
        self.overlapping_pending_requests.each do |pending_request|
          # debugger
          pending_request.deny!
        end
      end
    end
  end

  def deny!
    self.update(status: 'DENIED')
  end

  def pending?
    self.status == 'PENDING'
  end


end