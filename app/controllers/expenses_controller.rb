class ExpensesController < ApplicationController

  def index
    puts("CALLING INDEX")
    puts "PARAMS"
    month = params['month'].present? ? params['month'] : Date.current.month
    @grouped_expenses_by_expense_date = Expense.current_month_grouped_by_expense_date(month)
    grouped_expenses_by_category = Expense.current_month_grouped_by_category(month)
    monthly_expenses = @grouped_expenses_by_expense_date.values.flatten.sum {|e| e['amount']}

    @grouped_by_category_percentages = grouped_expenses_by_category.transform_values do |expenses|
      sum = expenses.sum { |expense| ((expense["amount"].to_f / monthly_expenses) * 100).to_f.round(1) }
    end.sort_by  {|k,v| v}.reverse.to_h

    @grouped_by_category_values = grouped_expenses_by_category.transform_values do |expenses|
      sum = expenses.sum { |expense| expense['amount'] }
    end.sort_by  {|k,v| v}.reverse.to_h
    if params['month']
      @total_monthly_expenses = @grouped_expenses_by_expense_date.values.flatten.sum {|expense| expense['amount']}
    else
      @expenses_today = @grouped_expenses_by_expense_date[Date.today.strftime("%d/%m/%Y")].sum {|e| e['category_title'] != 'Accommodation' ?  e['amount'] : 0}
    end

    respond_to do |format|
      format.html
      format.json { render :json => {
        expenses_by_expense_date: @grouped_expenses_by_expense_date,
        expenses_by_category_percentages: @grouped_by_category_percentages,
        category_values: @grouped_by_category_values,
        month: params['month']
      } }
    end
  end

end
