import { useState, useEffect } from 'react';
import api from '../services/api';

const EmployeeDetails = ({ employeeId, onBack, onEdit }) => {
  const [employee, setEmployee] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  useEffect(() => {
    if (employeeId) {
      fetchEmployeeDetails();
    } else {
      setError('Invalid employee ID');
      setLoading(false);
    }
  }, [employeeId]);

  const fetchEmployeeDetails = async () => {
    try {
      setLoading(true);
      const data = await api.getEmployee(employeeId);
      setEmployee(data);
      setError(null);
    } catch (err) {
      console.error('Error fetching employee:', err);
      if (err.response && err.response.status === 404) {
        setError(`Employee with ID ${employeeId} not found`);
      } else {
        setError('Failed to fetch employee details. Please try again.');
      }
      setEmployee(null);
    } finally {
      setLoading(false);
    }
  };

  if (loading) return <div className="loading">Loading employee details...</div>;
  if (error) return <div className="error">{error}</div>;
  if (!employee) return <div className="error">Employee not found</div>;

  return (
    <div className="employee-details">
      <h2>Employee Details</h2>
        <div className="employee-image">
        <img 
          src={employee.employeeThumbnail || 'data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22100%22%20height%3D%22100%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20100%20100%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E#holder_189a44cfcbc text { fill: #999; font-weight: normal; font-family: Arial, Helvetica, Open Sans, sans-serif, monospace; font-size: 10pt } %3C/style%3E %3C/defs%3E %3Cg id=%22holder_189a44cfcbc%22 %3E %3Crect width=%22100%22 height=%22100%22 fill=%22FFFFFF%22 %3E %3C/rect %3E %3C/g %3E %3C/svg %3E'}
          alt={`${employee.firstName} ${employee.lastName}`} 
          onError={(e) => {
            e.target.onerror = null;
            e.target.src = 'data:image/svg+xml;charset=UTF-8,%3Csvg%20width%3D%22100%22%20height%3D%22100%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20100%20100%22%20preserveAspectRatio%3D%22none%22%3E%3Cdefs%3E%3Cstyle%20type%3D%22text%2Fcss%22%3E%23holder_189a44cfcbc%20text%20%7B%20fill%3A%23999%3Bfont-weight%3Anormal%3Bfont-family%3AArial%2C%20Helvetica%2C%20Open%20Sans%2C%20sans-serif%2C%20monospace%3Bfont-size%3A10pt%20%7D%20%3C%2Fstyle%3E%3C%2Fdefs%3E%3Cg%20id%3D%22holder_189a44cfcbc%22%3E%3Crect%20width%3D%22100%22%20height%3D%22100%22%20fill%3D%22%23FFFFFF%22%3E%3C%2Frect%3E%3C%2Fg%3E%3C%2Fsvg%3E';
          }}
        />
      </div>
      
      <div className="details-container">
        <div className="detail-row">
          <span className="label">Employee ID:</span>
          <span className="value">{employee.employeeId}</span>
        </div>
        <div className="detail-row">
          <span className="label">Name:</span>
          <span className="value">{employee.firstName} {employee.lastName}</span>
        </div>
        <div className="detail-row">
          <span className="label">Email:</span>
          <span className="value">{employee.workEmail}</span>
        </div>
        <div className="detail-row">
          <span className="label">Job Role:</span>
          <span className="value">{employee.jobRole}</span>
        </div>
      </div>
      
      <div className="action-buttons">
        <button onClick={onBack}>Back to List</button>
        <button onClick={() => onEdit(employeeId)}>Edit Employee</button>
      </div>
    </div>
  );
};

export default EmployeeDetails;