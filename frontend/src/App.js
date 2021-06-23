import logo from "./logo.svg";
import "./App.css";
import StageDisplay from "./components/StageDisplay";
import Modal from "./components/Modal";
import { useEffect, useState } from "react";
import Validation from "./validations";

import axios from "axios";


function App() {
  const [modalValue, setModalValue] = useState("");
  const [showNotification, setShowNotification] = useState(false);
  const [stage, setStage] = useState(0);
  const [state, setState] = useState({
    boardSize: 0,
    opponent: "",
    playFirst: undefined,
    board: [...Array(9).keys()],
    currrentSymbol: "X",
    notificationText: "Invalid response",
  });

  const [showModal, setShowModal] = useState(false);

  const URL = "http://localhost:3000/move";

  const STAGEVALUE = {
    0: state.boardSize,
    1: state.opponent,
    2: state.playFirst,
  };

  const defaultBoard = () => {
    return [...Array(9).keys()];
  };

  const computersTurn = () => {
    const computer_opponent = ["s", "c"].includes(state.opponent);
    const computer_move = state.currrentSymbol == "O";
    return computer_opponent && computer_move;
  };

  useEffect(() => {
    processGameNotification();

    if (computersTurn()) makeComputerMove();
  }, [stage, state.currrentSymbol]);

  const makeComputerMove = async () => {
    const type = state.opponent == "s" ? "smart_computer" : "computer";
    const data = {
      state: state.board,
      type,
      symbol: state.currrentSymbol,
    };

    const res = await axios.post(URL, data);
    const computer_move = res.data["move"];
    updateBoard(computer_move)
  };

  const isTerminalState = async (board, symbol) => {
    const type =
      state.opponent == "s"
        ? "smart_computer"
        : state.opponent == "c"
        ? "computer"
        : "human";

    const body = {
      state: board,
      type,
      symbol: symbol,
    };

    try {
      const res = await axios.post(URL, body);
      const { game_state } = res.data;
      if (["win", "draw"].includes(game_state)) {
        const terminalText = `Game is a ${game_state.toUpperCase()}`;
        setModalValue(terminalText);
        setShowModal(true);
        setStage(0);
      }

      return ["win", "draw"].includes(game_state);
    } catch (error) {
      console.log(error);
    }
    return false;
  };

  const updateBoard = async (givenIndex) => {
    const currentSymbol = state.currrentSymbol;
    const newSymbol = state.currrentSymbol === "X" ? "O" : "X";
    const newBoard = state.board.map((item, index) =>
      index === givenIndex ? currentSymbol : item
    );

    const terminal = await isTerminalState(newBoard, currentSymbol);

    if (terminal) return;

    setState({ ...state, board: newBoard, currrentSymbol: newSymbol });
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
          state.currrentSymbol === "X" ? "1" : "2"
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

  return (
    <div className="App">
      <header className="App-header">
        <h1 style={{font:'35px'}}>Welcome to tic-tac-toe game</h1>
        <br />
        <StageDisplay 
        stageNumber={stage} 
        showNotification={showNotification} 
        inputHandler={inputHandler} 
        buttonClickHandler={buttonClickHandler}
        board={state.board}
        updateBoard={updateBoard}
        />
        {showNotification && (
          <small data-testid="input-error">{state.notificationText}</small>
        )}
      </header>

      {showModal && (
        <Modal
          value={modalValue}
          onClick={() => {
            setShowModal(false);
            // setState({ ...state, board: defaultBoard() });
          }}
        />
      )}
    </div>
  );
}

export default App;
