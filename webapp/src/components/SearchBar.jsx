import { useState } from 'react';

const SearchBar = ({ onSearch }) => {
  const [query, setQuery] = useState('');
  const [jobRole, setJobRole] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    onSearch(query, jobRole);
  };

  const handleClear = () => {
    setQuery('');
    setJobRole('');
    onSearch('', '');
  };

  return (
    <div className="search-bar">
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          placeholder="Search by name, email or ID..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
        
        <select 
          value={jobRole}
          onChange={(e) => setJobRole(e.target.value)}
        >
          <option value="">All Job Roles</option>
          <option value="Software Engineer">Software Engineer</option>
          <option value="Senior Software Engineer">Senior Software Engineer</option>
          <option value="Tech Lead">Tech Lead</option>
          <option value="QA Engineer">QA Engineer</option>
          <option value="DevOps Engineer">DevOps Engineer</option>
        </select>
        
        <button type="submit">Search</button>
        
        {(query || jobRole) && (
          <button type="button" onClick={handleClear}>Clear</button>
        )}
      </form>
    </div>
  );
};

export default SearchBar;