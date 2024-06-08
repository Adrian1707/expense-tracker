class ExpensesController < ApplicationController

  def index
    @grouped_expenses = Expense
    .select("amount, expense_date, one_off, categories.title AS category_title")
    .joins(:category)
    .where("DATE_PART('month', expense_date) = ?", Date.current.month)
    .where('expense_date <= ?', Date.today)
    .map {|e| e.attributes}.group_by {|expense| expense['expense_date'].strftime("%d/%m/%Y")}
    monthly_expenses = @grouped_expenses.values.flatten.sum {|e| e['amount']}
    grouped_by_category = Expense
    .select("amount, expense_date, one_off, categories.title AS category_title")
    .joins(:category)
    .where("DATE_PART('month', expense_date) = ?", Date.current.month)
    .where('expense_date <= ?', Date.today)
    .map {|e| e.attributes}.group_by {|expense| expense['category_title']}

    @grouped_by_category_percentages = grouped_by_category.transform_values do |expenses|

      sum = expenses.sum { |expense| ((expense["amount"].to_f / monthly_expenses) * 100).to_f.round(1) }
    end.sort_by  {|k,v| v}.reverse.to_h
    @grouped_by_category_values = grouped_by_category.transform_values do |expenses|

      sum = expenses.sum { |expense| expense['amount'] }
    end.sort_by  {|k,v| v}.reverse.to_h
    @expenses_today = @grouped_expenses[Date.today.strftime("%d/%m/%Y")].sum {|e| e['amount']}
  end

end
