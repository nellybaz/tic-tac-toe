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
  it("shoud render input field", async ()=>{
    await act(async ()=>{
      render(<InputField />, container)
    })
  })
})