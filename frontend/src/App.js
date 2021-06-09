import logo from "./logo.svg";
import "./App.css";
import Board from "./components/Board";
import { useEffect, useState } from "react";
import Validation from "./validations";
import AppFixtures from "./fixtures/App";
import { StageOne } from "./components/StageOne";
import { StageTwo } from "./components/StageTwo";
import { StageThree } from "./components/StageThree";

function App() {
  const [showNotification, setShowNotification] = useState(false);
  const [stage, setStage] = useState(0);
  const [state, setState] = useState({
    boardSize: 0,
    opponent: "",
    playFirst: undefined,
    board: [...Array(9).keys()],
    currrenSymbol: "X",
    notificationText: "Invalid response",
  });

  const STAGEVALUE = {
    0: state.boardSize,
    1: state.opponent,
    2: state.playFirst,
  };

  useEffect(() => {
    processGameNotification();
    makeMoveForComputer();
  }, [stage, state.currrenSymbol]);

  const makeMoveForComputer=()=>{
    if(state.currrenSymbol === 'O' && state.opponent !== 'h' && stage === 3) {
      
      const randomMove = Math.floor(Math.random() * state.board.length)
      updateBoard(randomMove)
    }
  }

  const updateBoard = (givenIndex) => {
    const currentSymbol = state.currrenSymbol;
    const newSymbol = state.currrenSymbol === "X" ? "O" : "X";
    const newBoard = state.board.map((item, index) =>
      index === givenIndex ? currentSymbol : item
    );
    setState({ ...state, board: newBoard, currrenSymbol: newSymbol });
  };

  const getStageValue = (stage) => {
    return STAGEVALUE[stage];
  };

  const processGameNotification = () => {
    if (stage === 3) {
      setShowNotification(true);
      setState({
        ...state,
        notificationText: `Player ${
          state.currrenSymbol === "X" ? "1" : "2"
        }'s turn`,
      });
    }
  };

  const processNextStage = () => {
    if (state.opponent === "h" && stage === 1) setStage(stage + 2);
    else setStage(stage + 1);
  };

  const buttonClickHandler = (_) => {
    if (Validation.shouldShowError(stage, getStageValue(stage)))
      setShowNotification(true);
    else processNextStage();
  };

  const inputHandler = (event) => {
    const userInput = event.target.value;
    switch (stage) {
      case 0:
        const intValue = parseInt(userInput);
        setState({ ...state, boardSize: intValue });
        break;

      case 1:
        setState({
          ...state,
          opponent: userInput,
          board: [...Array(state.boardSize * state.boardSize).keys()],
        });
        break;

      case 2:
        setState({ ...state, playFirst: userInput === "y" });
        break;

      default:
        break;
    }
  };

  const stageDisplay = {
    0: (
      <StageOne
        showError={showNotification}
        inputHandler={inputHandler}
        buttonClickHandler={buttonClickHandler}
      />
    ),
    1: (
      <StageTwo
        options={AppFixtures.stageTwo()}
        inputHandler={inputHandler}
        buttonClickHandler={buttonClickHandler}
      />
    ),
    2: (
      <StageThree
        options={AppFixtures.stageThree()}
        inputHandler={inputHandler}
        buttonClickHandler={buttonClickHandler}
      />
    ),
    3: <Board board={state.board} clickHandler={updateBoard} />,
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" width={"100vw"} />
        <h3>Welcome to tic-tac-toe game</h3>

        <br />
        {stageDisplay[stage]}
        {showNotification && (
          <small data-testid="input-error">{state.notificationText}</small>
        )}
      </header>
    </div>
  );
}

export default App;
