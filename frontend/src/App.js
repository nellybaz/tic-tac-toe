import logo from './logo.svg';
import './App.css';
import InputField from './components/InputField/index';
import Cell from './components/Cell';
import { useState } from 'react';
import AppAction from './actions/App.action';

function App() {
  const [showError, setShowError] = useState(false)
  const [stage, setStage] = useState(0)
  const [state, setState] = useState({ boardSize: 0, opponent: 'c', playFirst: true })

  const gotoNextStage = (event) => {
    const shouldShowError = AppAction.shouldShowError(state.boardSize, event.key)
    setShowError(shouldShowError)
    if (!shouldShowError && event.key == 'Enter') setStage(stage + 1)
  }

  const inputHandler = (event) => {
    const userInput = event.target.value
    switch (stage) {
      case 0:
        setState({...state, boardSize:userInput})
        break;
    
      default:
        break;
    }
  } 

  const stageDisplay = {
    0: <InputField label='Enter the size of the board' onChange={inputHandler} onKeyUp={gotoNextStage} showError={showError} />,
    1: <InputField label='Choose opponent. [c for computer, s for smart computer, h for human]' onChange={inputHandler} onKeyUp={gotoNextStage} showError={showError} />,
    2: <InputField label='Do you want to play first? Y for yes' onChange={inputHandler} onKeyUp={gotoNextStage} showError={showError} />,
    3: (<div><Cell value={0}/></div>)
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
