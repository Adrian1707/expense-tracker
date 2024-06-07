class ExpensesController < ApplicationController

  def index
    @grouped_expenses = Expense
    .select("amount, expense_date, one_off, categories.title AS category_title")
    .joins(:category)
    .where("DATE_PART('month', expense_date) = ?", Date.current.month)
    .map {|e| e.attributes}.group_by {|expense| expense['expense_date'].strftime("%d/%m/%Y")}
  end

end
