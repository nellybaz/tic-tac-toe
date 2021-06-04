import React from 'react'

export default function Cell(props){
  return <div data-testid={`cell-${props.value}`} onClick={props.clickHandler}>{props.value}</div>
}