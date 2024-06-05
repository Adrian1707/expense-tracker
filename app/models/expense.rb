class Expense < ApplicationRecord
  belongs_to :category

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
   ["amount", "category_id", "created_at", "description", "expense_date", "id", "id_value", "one_off", "purchase_date", "updated_at"]
  end

end
