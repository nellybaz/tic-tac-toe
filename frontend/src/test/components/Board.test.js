import { render, unmountComponentAtNode } from "react-dom";
import { act } from "react-dom/test-utils";
import Board from '../../components/Board';

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

describe("Board", () => {
  it("shoud render with the right value", async () => {
    const value = '0'
    await act(async () => {
      render(<Board value={value} />, container)
    })
    for (let index = 0; index < 9; index++)
      expect(container.querySelector(`[data-testid='cell-${index}']`).textContent).toEqual(index.toString())
  })

  xit("shoud call the function on user click event", async () => {
    const value = '0';
    const clickHandler = jest.fn()

    await act(async () => {
      render(<Board value={value} clickHandler={clickHandler} />, container)
    })

    const cell = container.querySelector("[data-testid='board']")
    expect(cell.textContent).toEqual(value)

    act(() => {
      cell.dispatchEvent(new MouseEvent("click", { bubbles: true }))
    })

    expect(clickHandler).toHaveBeenCalledTimes(1)
  })
})