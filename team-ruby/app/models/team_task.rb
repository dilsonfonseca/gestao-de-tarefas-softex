class TeamTask < ApplicationRecord
  validates :title, :description, :status, :assigned_to, :due_date, presence: true
  validate :due_date_after_created_at
  private

  def due_date_after_created_at
    return if due_date.blank?

    # Usa created_at se já existir, senão usa Time.current (para criação)
    comparison_date = created_at || Time.current

    if due_date <= comparison_date.to_date
      errors.add(:due_date, "deve ser posterior à data de criação")
    end
  end
end
