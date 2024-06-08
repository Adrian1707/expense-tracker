import React from "react"
import PropTypes from "prop-types"
import { Bar, Pie } from 'react-chartjs-2';
import annotationPlugin from 'chartjs-plugin-annotation';
import ChartDataLabels from 'chartjs-plugin-datalabels';
import { Chart as ChartJS, ArcElement, CategoryScale, LinearScale, BarElement, Tooltip, Legend } from 'chart.js';
ChartJS.register(ArcElement, CategoryScale, LinearScale, BarElement, Tooltip, Legend, annotationPlugin, ChartDataLabels);

const HelloWorld = (props) => {
  ChartJS.overrides.pie.plugins.legend.display = false
  ChartJS.defaults.set('plugins.datalabels', {
    display: false
  });
  const labels = Object.keys(props.expenseData);
  console.log(Object.values(props.categoryData))
  const pieData = {
    labels: Object.keys(props.categoryData),
    datasets: [
      {
        data: Object.values(props.categoryData),
        backgroundColor: [
          '#FF6384', // Red
          '#36A2EB', // Blue
          '#FFCE56', // Yellow
          '#8BC34A', // Green
          '#9370DB', // Purple
          '#FF9800', // Orange
          '#4FC3F7', // Light Blue
          '#E57373', // Red Shade
          '#81C784', // Green Shade
          '#BA68C8', // Purple Shade
          '#FFB74D', // Orange Shade
          '#4DD0E1', // Cyan
          '#E57373', // Red Shade
          '#81C784', // Green Shade
          '#BA68C8'  // Purple Shade
        ]
      },
    ],
  };

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

  const pieOptions = {
    plugins: {
      datalabels: {
        formatter: function(value, context) {
          return value.toFixed(2).toString() + "%";
        },
        backgroundColor: '#ffffff',
        display: true,
        align: 'bottom',
        borderRadius: 3,
        font: {
          size: 10,
        },
      },
    },
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
    plugins: {
    annotation: {
      annotations: {
        line1: {
          type: 'line',
          yMin: 80,
          yMax: 80,
          borderColor: 'rgb(255, 0, 0)',
          borderWidth: 2,
          label: {
            enabled: true,
            content: 'Budget',
            position: 'start'
          }
        }
      }
    }
  }
  };
  return(
    <div>
      <Bar data={data} options={options} />;
      <Pie data={pieData} options={pieOptions} />;
      <table className="expenses-table">
        <thead>
          <tr>
            <th>Category</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody>
          {Object.entries(props.categoryValues).map(([category, amount]) => (
            <tr key={category}>
              <td>{category}</td>
              <td>${amount.toFixed(2)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )

}

HelloWorld.propTypes = {
  greeting: PropTypes.string
};

export default HelloWorld
