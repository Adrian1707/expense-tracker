import React from "react"
import PropTypes from "prop-types"
import { Bar } from 'react-chartjs-2';
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Tooltip, Legend } from 'chart.js';

ChartJS.register(CategoryScale, LinearScale, BarElement, Tooltip, Legend);

const HelloWorld = (props) => {
  const labels = Object.keys(props.expenseData);

  const data = {
    labels,
    datasets: [
      {
        label: 'Expenses',
        data: labels.map(date => props.expenseData[date].reduce((total, expense) => total + expense.amount, 0)),
        backgroundColor: 'rgba(75, 192, 192, 0.6)',
      },
    ],
  };

  const options = {
    scales: {
      x: {
        type: 'category',
      },
      y: {
        type: 'linear',
        beginAtZero: true,
      },
    },
  };
  return <Bar data={data} options={options} />;
  
}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};

export default HelloWorld
