import { render, screen } from '@testing-library/react';
import App from '../App';
import AppAction from '../actions/App.action'

test('renders welcome text', () => {
  render(<App />);
  const linkElement = screen.getByText(/welcome to tic-tac-toe game/i);
  expect(linkElement).toBeInTheDocument();
});

it('should check whether to show input error', () => {
  expect(AppAction.shouldShowError("a", "Enter")).toEqual(false)
  expect(AppAction.shouldShowError("", "Enter")).toEqual(true)
  expect(AppAction.shouldShowError("y", "Enter")).toEqual(false)
})