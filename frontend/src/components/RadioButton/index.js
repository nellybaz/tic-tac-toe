export default function RadioButton(props){
  return (<div data-testid='radio-button'>
    {
      props.options.map((item, index)=><input key={index} data-testid={`options-${item.id}`} type='radio' value={item.value} />)
    }
  </div>)
}