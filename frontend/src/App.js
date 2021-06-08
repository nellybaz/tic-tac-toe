import logo from './logo.svg';
import './App.css';
import InputField from './components/InputField/index';
import Board from './components/Board';
import { useState } from 'react';
import Button from "./components/Button"
import RadioButton from './components/RadioButton'
import Validation from './validations';
import AppFixtures from './fixtures/App'

function App() {
  const [showError, setShowError] = useState(false)
  const [stage, setStage] = useState(0)
  const [state, setState] = useState({ boardSize: 0, opponent: 'c', playFirst: true })

  const STAGEVALUE = {0:state.boardSize, 1: state.opponent, 2: state.playFirst}

  const getStageValue = (stage) => {
    return STAGEVALUE[stage]
  }

  const buttonClickHandler = _ => {
    if (Validation.shouldShowError(stage, getStageValue(stage))) setShowError(true)
    else setStage(stage + 1)
  }

  const inputHandler = (event) => {
    const userInput = event.target.value
    switch (stage) {
      case 0:
        setState({ ...state, boardSize: parseInt(userInput) })
        break;

      case 1:
        setState({ ...state, opponent: userInput })
        break;

      case 2:
        setState({ ...state, playFirst: userInput === 'y' })
        break;

      default:
        break;
    }
  }

  const stageOne = (<div> <InputField label='Enter the size of the board' type='number' onChange={inputHandler} onKeyUp={buttonClickHandler} showError={showError} /> <Button label='Next' onClick={buttonClickHandler} /></div>)
  const stageTwo = (<div> <h4>Choose player</h4> <RadioButton options={AppFixtures.stageTwo()} onChange={inputHandler} /> <Button label='Next' onClick={buttonClickHandler} /></div>)
  const stageThree = (<div> <h4>Do you wanna play first?</h4> <RadioButton options={AppFixtures.stageThree()} onChange={inputHandler} /> <Button label='Next' onClick={buttonClickHandler} /></div>)

  const stageDisplay = {
    0: stageOne,
    1: stageTwo,
    2: stageThree,
    3: <Board size={state.boardSize}/>
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
        {
          showError && <small data-testid='input-error'>Invalid response</small>
        }
      </header>
    </div>
  );
}

export default App;
