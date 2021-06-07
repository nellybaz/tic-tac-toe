import logo from './logo.svg';
import './App.css';
import InputField from './components/InputField/index';
import Board from './components/Board';
import { useState } from 'react';
import AppAction from './actions/App.action';
import Button from "./components/Button"
import RadioButton from './components/RadioButton'

function App() {
  const [showError, setShowError] = useState(false)
  const [stage, setStage] = useState(0)
  const [state, setState] = useState({ boardSize: 0, opponent: 'c', playFirst: true })

  const buttonClickHandler = (event) => {
    if (state.boardSize == 0) setShowError(true)
    else setStage(stage + 1)
  }

  const inputHandler = (event) => {
    const userInput = event.target.value
    switch (stage) {
      case 0:
        setState({ ...state, boardSize: parseInt(userInput) })
        break;

      default:
        break;
    }
  }

  const stageTwoOptions = [
    {
      id: 1,
      value: 'c',
      label: 'Computer'
    },
    {
      id: 2,
      value: 'h',
      label: 'Human'
    },
    {
      id: 3,
      value: 's',
      label: 'Smart Computer'
    }
  ]
  const playFirstOptions = [
    {
      id: 1,
      value: 'y',
      label: 'Yes'
    },
    {
      id: 2,
      value: 'n',
      label: 'No'
    },
  ]

  const stageOne = (<div> <InputField label='Enter the size of the board' type='number' onChange={inputHandler} onKeyUp={buttonClickHandler} showError={showError} /> <Button label='Next' onClick={buttonClickHandler} /></div>)
  const stageTwo = (<div> <h4>Choose player</h4> <RadioButton options={stageTwoOptions} /> <Button label='Next' onClick={buttonClickHandler} /></div>)
  const stageThree = (<div> <h4>Do you wanna play first?</h4> <RadioButton options={playFirstOptions} /> <Button label='Next' onClick={buttonClickHandler} /></div>)

  const stageDisplay = {
    0: stageOne,
    1: stageTwo,
    2: stageThree,
    3: (<div><Board /></div>)
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" width={'100vw'} />
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
