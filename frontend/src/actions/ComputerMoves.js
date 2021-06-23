import axios from "axios";

const URL = "http://localhost:3000/move";

export class ComputerMove {
  static async make(opponent, board, currentSymbol, callback){
      const type = opponent == "s" ? "smart_computer" : "computer";
      const data = {
        state: board,
        type,
        symbol: currentSymbol,
      };
    
      const res = await axios.post(URL, data);
      const computer_move = res.data["move"];
      callback(computer_move);
    };

    static isTurn(opponent, currentSymbol){
      const computer_opponent = ["s", "c"].includes(opponent);
      const computer_move = currentSymbol == "O";
      return computer_opponent && computer_move;
    }
}