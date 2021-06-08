import Cell from "../Cell"
import './index.css'


export default function Board(props) {
  const getSize = () => (props.size * props.size) || 9

  const style = {
    display: 'grid',
    gridTemplateColumns: `repeat(${props.size || 3}, 1fr)`
  }
  return (
    <div style={style} data-testid='board'>{
      [...Array(getSize()).keys()].map((index) =>
        <Cell key={index} value={index} clickHandler={() => { alert(0) }} />
      )
    }</div>
  )
}
