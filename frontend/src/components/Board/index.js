import Cell from "../Cell"
import './index.css'


export default function Board() {
  return (
    <div className='board' data-testid='board'>{
      [...Array(9).keys()].map((index)=>
        <Cell key={index} value={index} clickHandler={()=>{alert(0)}}/>
      )
    }</div>
  )
}