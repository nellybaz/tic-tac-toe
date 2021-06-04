import './index.css'

export default function InputField(props) {

  return (<div>
    <label htmlFor='input-field' data-testid='input-label'>{props.label}</label> <br />
    <input data-testid='input' id='input-field' onChange={props.onChange} onKeyUp={props.onKeyUp} placeholder='Hit enter after response'></input><br />
    {
      props.showError && <small data-testid='input-error'>Response is required</small>
    }
  </div>)
}