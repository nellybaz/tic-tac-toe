import logo from './logo.svg';
import './App.css';
import InputField from './components/InputField/InputField';
import { useState } from 'react';
import AppAction from './actions/App.action';

function App() {
  const [showError, setShowError] = useState(false)
  const [boardSize, setBoardSize] = useState('')
  const [stage, setStage] = useState(0)

  const onKeyUp = (event) => {
    const shouldShowError = AppAction.shouldShowError(boardSize, event.key)
    setShowError(shouldShowError)
    if(!shouldShowError && event.key == 'Enter') setStage(stage+1)
  }

  const onChange = (event) => {
    if (stage == 0) setBoardSize(event.target.value)
  }
  
  const stageDisplay = {
    0: <InputField label='Enter the size of the board' onChange={onChange} onKeyUp={onKeyUp} showError={showError} />,
    1: <InputField label='Choose opponent. [c for computer, s for smart computer, h for human]' onChange={onChange} onKeyUp={onKeyUp} showError={showError} />,
    2: <InputField label='Do you want to play first? Y for yes' onChange={onChange} onKeyUp={onKeyUp} showError={showError} />
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <h3>Welcome to tic-tac-toe game</h3>

        <br />
        {
          stageDisplay[stage]
        }
      </header>
    </div>
  );
}

export default App;
