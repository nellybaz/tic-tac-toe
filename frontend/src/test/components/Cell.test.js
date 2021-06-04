import { render, unmountComponentAtNode } from "react-dom";
import { act } from "react-dom/test-utils";
import Cell from '../../components/Cell';

let container = null
beforeEach(() => {
  container = document.createElement('div')
  document.body.append(container)
})

afterEach(() => {
  unmountComponentAtNode(container);
  container.remove();
  container = null;
})

describe("Cell", () => {
  it("shoud render with the right value", async () => {
    const value = '0'
    await act(async () => {
      render(<Cell value={value} />, container)
    })
    expect(container.querySelector("[data-testid='cell']").textContent).toEqual(value)
  })
})