import axios from "axios";
const URL = "http://localhost:3000/move";

export class GameRules{
  static async isTerminalState(board, symbol, opponent){
    const type =
      opponent == "s"
        ? "smart_computer"
        : opponent == "c"
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

      return {
        game_state,
        state: ["win", "draw"].includes(game_state),
      };
    } catch (error) {
      console.log(error);
    }

    return {
      state: null,
      game_state: null,
    };
  };
}