export default function InputField(props){
  return (<div>
    <label htmlFor='input-field' data-testid='inputlabel'>{props.label}</label>
    <input data-testid='input' id='input-field' placeholder='Enter response'></input>
  </div>)
}