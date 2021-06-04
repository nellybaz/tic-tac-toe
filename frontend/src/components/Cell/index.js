import React from 'react'
import './index.css'

export default function Cell(props){
  return <div className='cell' data-testid={`cell-${props.value}`} onClick={()=>props.clickHandler(props.value)}>{props.value}</div>
}