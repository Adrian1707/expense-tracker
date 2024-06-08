class ExpensesController < ApplicationController

  def index
    @grouped_expenses_by_expense_date = Expense.current_month_grouped_by_expense_date
    grouped_expenses_by_category = Expense.current_month_grouped_by_category
    monthly_expenses = @grouped_expenses_by_expense_date.values.flatten.sum {|e| e['amount']}

    @grouped_by_category_percentages = grouped_expenses_by_category.transform_values do |expenses|
      sum = expenses.sum { |expense| ((expense["amount"].to_f / monthly_expenses) * 100).to_f.round(1) }
    end.sort_by  {|k,v| v}.reverse.to_h

    @grouped_by_category_values = grouped_expenses_by_category.transform_values do |expenses|
      sum = expenses.sum { |expense| expense['amount'] }
    end.sort_by  {|k,v| v}.reverse.to_h

    @expenses_today = @grouped_expenses_by_expense_date[Date.today.strftime("%d/%m/%Y")].sum {|e| e['category_title'] != 'Accommodation' ?  e['amount'] : 0}
  end

end
