import { render, unmountComponentAtNode } from "react-dom";
import { act } from "react-dom/test-utils";
import InputField from '../../components/InputField';

let container = null
beforeEach(()=>{
  container = document.createElement('div')
  document.body.append(container)
})

afterEach(()=>{
  unmountComponentAtNode(container);
  container.remove();
  container = null;
})

describe("InputField", ()=>{
  it("shoud render input field with the right label", async ()=>{
    const label = 'Enter board size'
    await act(async ()=>{
      render(<InputField label={label}/>, container)
    })
    expect(container.querySelector("[data-testid='inputlabel']").textContent).toEqual(label)
    expect(container.querySelector("[data-testid='input']").placeholder).toEqual('Enter response')
  })

})