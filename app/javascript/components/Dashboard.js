import React from "react"
import BarChart from './BarChart'
import PieChart from './PieChart'
import Table from './Table'

const Dashboard = (props) => {
  return(
    <div>
      <BarChart expensesByExpenseDate={props.expensesByExpenseDate} />
      <PieChart expensesByCategory={props.expensesByCategory} />
      <Table categoryValues={props.categoryValues} />
    </div>
  )

}

export default Dashboard
