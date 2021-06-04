import Cell from "../Cell"

export default function Board() {
  return (
    <div data-testid='board'>{
      [...Array(9).keys()].map((index)=>
        <Cell key={index} value={index} />
      )
    }</div>
  )
}