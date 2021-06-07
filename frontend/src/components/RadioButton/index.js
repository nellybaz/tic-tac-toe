export default function RadioButton(props) {
  return (<div data-testid='radio-button'>
    {
      props.options.map((item, index) => (<div key={index} >
        <input onChange={props.onChange} data-testid={`options-${item.id}`} type='radio' value={item.value} />
        <label data-testid={`options-${item.id}-label`}>{item.label}</label>
      </div>))
    }
  </div>)
}