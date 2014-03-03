class Payment < ActiveRecord::Base
  belongs_to :reservation
  validates :reservation_id, :amount, presence: true
  validates_numericality_of :amount, greater_than: 0
  before_save :validate_amount

  def validate_amount
    if self.reservation.amount == self.reservation.total_payment
      self.errors[:base] << "La reserva ya se encuentra pagada."
      return false
    elsif self.reservation.amount < self.reservation.total_payment + self.amount
      to_be_payd = self.reservation.amount - self.reservation.total_payment
      self.errors[:base] << "El monto del pago debe ser menor a $#{to_be_payd}."
      return false
    end
  end
end
