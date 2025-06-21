import React, { useState, useEffect } from 'react';
import api from '../services/api';

const EmployeeList = ({ onEdit, onView, onDeleteSuccess }) => {
  const [employees, setEmployees] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchEmployees();
  }, []);

  const fetchEmployees = async () => {
    try {
      setLoading(true);
      const data = await api.getAllEmployees();
      setEmployees(data);
      setError(null);
    } catch (err) {
      setError('Failed to fetch employees. Please try again later.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id, e) => {
    if (e) e.preventDefault();
    
    if (window.confirm('Are you sure you want to delete this employee?')) {
      try {
        await api.deleteEmployee(id);
        setEmployees(employees.filter(emp => emp.employeeId !== id));
        if (onDeleteSuccess) onDeleteSuccess(id);
      } catch (err) {
        console.error('Delete failed:', err);
        alert('Failed to delete employee. Please try again.');
      }
    }
  };

  if (loading) return <div className="loading">Loading employees...</div>;
  if (error) return <div className="error">{error}</div>;

  return (
    <div className="employee-list">
      <h2>Employees</h2>
      {employees.length === 0 ? (
        <p>No employees found.</p>
      ) : (
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Job Role</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {employees.map(employee => (
              <tr key={employee.employeeId}>
                <td>{employee.employeeId}</td>
                <td>{employee.firstName} {employee.lastName}</td>
                <td>{employee.workEmail}</td>
                <td>{employee.jobRole}</td>
                <td>
                  <button onClick={() => onView(employee.employeeId)}>View</button>
                  <button onClick={() => onEdit(employee.employeeId)}>Edit</button>
                  <button onClick={(e) => handleDelete(employee.employeeId, e)}>Delete</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default EmployeeList;
