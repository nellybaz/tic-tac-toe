import logo from './logo.svg';
import './App.css';
import InputField from './components/InputField/InputField';

function App() {
  const onEnter = () => { alert('hi') }
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h3>Welcome to tic-tac-toe game</h3>

        <br />
        <InputField label='Enter the size of the board' onEnter={onEnter} />
      </header>
    </div>
  );
}

export default App;
