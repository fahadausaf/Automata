
// some states for test cases
abstract class State
case object Q0 extends State
case object Q1 extends State
case object Q2 extends State

def delta(s: State, c: Char) : Set[State] = (s, c) match{
  case (Q0, 'a') => Set(Q1, Q2)
  case (Q0, 'b') => Set(Q0)
  case (Q1, 'a') => Set(Q1, Q2)
  case (Q1, 'b') => Set(Q0, Q1)
}