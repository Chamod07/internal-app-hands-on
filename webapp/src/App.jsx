import { useState, useEffect } from 'react'
import './App.css'
import EmployeeList from './components/EmployeeList'
import EmployeeForm from './components/EmployeeForm'
import EmployeeDetails from './components/EmployeeDetails'
import SearchBar from './components/SearchBar'
import api from './services/api'

function App() {
  const [view, setView] = useState('list') // list, add, edit, view
  const [selectedEmployeeId, setSelectedEmployeeId] = useState(null)
  const [employees, setEmployees] = useState([])
  const [searchResults, setSearchResults] = useState(null)
  
  useEffect(() => {
    const fetchEmployees = async () => {
      try {
        const data = await api.getAllEmployees();
        setEmployees(data);
      } catch (error) {
        console.error('Error fetching employees:', error);
      }
    };
    
    fetchEmployees();
  }, []);

  const handleSearch = async (searchTerm, jobRole) => {
    if ((!searchTerm || !searchTerm.trim()) && !jobRole) {
      setSearchResults(null);
      return;
    }

    try {
      const results = await api.searchEmployees(searchTerm, jobRole);
      setSearchResults(results);
    } catch (error) {
      console.error('Search error:', error);
      alert('Failed to search employees. Please try again.');
    }
  };

  const handleSaveEmployee = (savedEmployee) => {
    setView('list');
    setSearchResults(null);
  };

  const handleCancel = () => {
    setView('list');
    setSelectedEmployeeId(null);
  };

  const handleDeleteSuccess = (deletedId) => {
    if (view === 'view' && selectedEmployeeId === deletedId) {
      setView('list');
      setSelectedEmployeeId(null);
    }
  };

  const displayedEmployees = searchResults || employees;

  return (
    <div className="app-container">
      <h1>Employee Management System</h1>
      
      {view === 'list' && (
        <>
          <div className="action-bar">
            <button onClick={() => setView('add')}>Add New Employee</button>
            <SearchBar onSearch={handleSearch} />
          </div>
          
          <EmployeeList 
            employees={displayedEmployees}
            onView={(id) => {
              setSelectedEmployeeId(id);
              setView('view');
            }}
            onEdit={(id) => {
              setSelectedEmployeeId(id);
              setView('edit');
            }}
            onDeleteSuccess={handleDeleteSuccess}
          />
          
          {searchResults && (
            <button 
              className="clear-search" 
              onClick={() => setSearchResults(null)}
            >
              Clear Search Results
            </button>
          )}
        </>
      )}
      
      {view === 'add' && (
        <EmployeeForm 
          onSave={handleSaveEmployee} 
          onCancel={handleCancel} 
        />
      )}
      
      {view === 'edit' && (
        <EmployeeForm 
          employeeId={selectedEmployeeId} 
          onSave={handleSaveEmployee} 
          onCancel={handleCancel} 
        />
      )}
      
      {view === 'view' && (
        <EmployeeDetails 
          employeeId={selectedEmployeeId} 
          onBack={handleCancel}
          onEdit={(id) => {
            setSelectedEmployeeId(id);
            setView('edit');
          }} 
        />
      )}
    </div>
  )
}

export default App
