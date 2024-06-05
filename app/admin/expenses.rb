ActiveAdmin.register Expense do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :amount, :category_id, :description, :one_off, :expense_date, :purchase_date
  #
  # or
  #
  # permit_params do
  #   permitted = [:amount, :category_id, :description, :one_off, :expense_date, :purchase_date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # form do |f|
  #  f.input :expense_date, as: :date_time_picker, datepicker_options: { min_date: "2013-10-8"}
  #  f.input :purchase_date,   as: :date_time_picker, datepicker_options: { min_date: 3.days.ago.to_date }
  # end

end
