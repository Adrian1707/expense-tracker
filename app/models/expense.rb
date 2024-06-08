class Expense < ApplicationRecord
  belongs_to :category

  scope :current_month_grouped_by_category, -> {
    select("amount, expense_date, one_off, categories.title AS category_title")
     .joins(:category)
     .where("DATE_PART('month', expense_date) = ?", Date.current.month)
     .where('expense_date <= ?', Date.today)
     .map {|e| e.attributes}.group_by {|expense| expense['category_title']}
  }

  scope :current_month_grouped_by_expense_date, -> {
    select("amount, expense_date, one_off, categories.title AS category_title")
    .joins(:category)
    .where("DATE_PART('month', expense_date) = ?", Date.current.month)
    .where('expense_date <= ?', Date.today)
    .map {|e| e.attributes}.group_by {|expense| expense['expense_date'].strftime("%d/%m/%Y")}
  }

  def self.ransackable_associations(auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(auth_object = nil)
   ["amount", "category_id", "created_at", "description", "expense_date", "id", "id_value", "one_off", "purchase_date", "updated_at"]
  end
end
