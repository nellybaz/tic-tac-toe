import RadioButton from '../RadioButton';
import Button from "../Button"

export function StageTwo(props){
  return (<div> <h4>Choose player</h4> <RadioButton options={props.aptions} onChange={props.inputHandler} /> <Button label='Next' onClick={props.buttonClickHandler} /></div>)
}