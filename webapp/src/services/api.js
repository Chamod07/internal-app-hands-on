import axios from 'axios';

const API_URL = 'http://localhost:9090/api/v1';

const api = {
  // Get all employees
  getAllEmployees: async () => {
    try {
      const response = await axios.get(`${API_URL}/employees`);
      return response.data;
    } catch (error) {
      console.error('Error fetching employees:', error);
      throw error;
    }
  },

  // Get a single employee by ID
  getEmployee: async (id) => {
    try {
      const response = await axios.get(`${API_URL}/employees/${id}`);
      return response.data;
    } catch (error) {
      console.error(`Error fetching employee ${id}:`, error);
      throw error;
    }
  },
  
  // Search employees
  searchEmployees: async (searchTerm, jobRole) => {
    try {
      let url = `${API_URL}/employees`;
      const params = new URLSearchParams();
      
      if (searchTerm && searchTerm.trim()) {
        params.append('searchTerm', searchTerm.trim());
      }
      
      if (jobRole) {
        params.append('jobRole', jobRole);
      }
      
      if (params.toString()) {
        url += `?${params.toString()}`;
      }
      
      const response = await axios.get(url);
      return response.data;
    } catch (error) {
      console.error('Error searching employees:', error);
      throw error;
    }
  },

  // Create a new employee
  createEmployee: async (employeeData) => {
    try {
      const response = await axios.post(`${API_URL}/employees`, employeeData);
      return response.data;
    } catch (error) {
      console.error('Error creating employee:', error);
      throw error;
    }
  },

  // Update an employee
  updateEmployee: async (id, employeeData) => {
    try {
      const response = await axios.put(`${API_URL}/employees/${id}`, employeeData);
      return response.data;
    } catch (error) {
      console.error(`Error updating employee ${id}:`, error);
      throw error;
    }
  },

  // Delete an employee
  deleteEmployee: async (id) => {
    try {
      await axios.delete(`${API_URL}/employees/${id}`);
      return true;
    } catch (error) {
      console.error(`Error deleting employee ${id}:`, error);
      throw error;
    }
  }
};

export default api;
