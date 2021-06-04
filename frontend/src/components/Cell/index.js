import React from 'react'
import ProtoTypes from 'prop-types'

export default function Cell(props){
  return <div data-testid='cell' onClick={props.clickHandler}>{props.value}</div>
}