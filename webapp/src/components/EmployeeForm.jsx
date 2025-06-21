import { useState, useEffect } from 'react';
import api from '../services/api';

const EmployeeForm = ({ employeeId, onSave, onCancel }) => {
  const [formData, setFormData] = useState({
    employeeId: '',
    workEmail: '',
    firstName: '',
    lastName: '',
    jobRole: '',
    employeeThumbnail: ''
  });
  
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    if (employeeId) {
      fetchEmployeeData();
    }
  }, [employeeId]);

  const fetchEmployeeData = async () => {
    try {
      setLoading(true);
      const data = await api.getEmployee(employeeId);
      setFormData(data);
      setError(null);
    } catch (err) {
      setError('Failed to fetch employee data. Please try again.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData(prevData => ({
      ...prevData,
      [name]: value
    }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      setLoading(true);
      let result;
      
      if (employeeId) {
        result = await api.updateEmployee(employeeId, formData);
      } else {
        result = await api.createEmployee(formData);
      }
      
      onSave(result);
    } catch (err) {
      setError('Failed to save employee. Please check your data and try again.');
      console.error(err);
    } finally {
      setLoading(false);
    }
  };
  if (loading && employeeId) return <div className="loading">Loading employee data...</div>;

  return (
    <div className="employee-form">
      <h2>{employeeId ? 'Edit Employee' : 'Add New Employee'}</h2>
      {error && <div className="error">{error}</div>}
      
      <form onSubmit={handleSubmit}>
        <div className="form-group">
          <label htmlFor="employeeId">Employee ID</label>
          <input
            type="text"
            id="employeeId"
            name="employeeId"
            value={formData.employeeId || ''}
            onChange={handleChange}
            disabled={!!employeeId}
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="firstName">First Name</label>
          <input
            type="text"
            id="firstName"
            name="firstName"
            value={formData.firstName}
            onChange={handleChange}
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="lastName">Last Name</label>
          <input
            type="text"
            id="lastName"
            name="lastName"
            value={formData.lastName}
            onChange={handleChange}
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="workEmail">Work Email</label>
          <input
            type="email"
            id="workEmail"
            name="workEmail"
            value={formData.workEmail}
            onChange={handleChange}
            required
          />
        </div>
        
        <div className="form-group">
          <label htmlFor="jobRole">Job Role</label>
          <select
            id="jobRole"
            name="jobRole"
            value={formData.jobRole}
            onChange={handleChange}
            required
          >
            <option value="">Select a role</option>
            <option value="Software Engineer">Software Engineer</option>
            <option value="Senior Software Engineer">Senior Software Engineer</option>
            <option value="Tech Lead">Tech Lead</option>
            <option value="QA Engineer">QA Engineer</option>
            <option value="DevOps Engineer">DevOps Engineer</option>
          </select>
        </div>
        
        <div className="form-group">
          <label htmlFor="employeeThumbnail">Profile Image URL</label>
          <input
            type="text"
            id="employeeThumbnail"
            name="employeeThumbnail"
            value={formData.employeeThumbnail || ''}
            onChange={handleChange}
            placeholder="https://example.com/image.jpg"
          />
        </div>
        
        <div className="form-actions">
          <button type="button" onClick={onCancel}>Cancel</button>
          <button type="submit" disabled={loading}>
            {loading ? 'Saving...' : 'Save'}
          </button>
        </div>
      </form>
    </div>
  );
};

export default EmployeeForm;
