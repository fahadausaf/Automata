

// some states for test cases
abstract class State
case object Q0 extends State
case object Q1 extends State
case object Q2 extends State
case object Q3 extends State
case object Q4 extends State

case class DFA(startState: State, delta: (State, Char) => State, finalStates: Set[State]) {
  def deltas(startState: State, input: List[Char]): State = (startState, input) match{
    case (s, c :: Nil) => delta(s, c)
    case (s, c :: cs) => deltas(delta(s, c), cs)
  }

  def accepts(s: List[Char]): Boolean = {
    finalStates.contains(deltas(startState, s))
  }
}

def delta(s: State, c: Char) : State = (s, c) match{
  case (Q0, 'a') => Q1
  case (Q0, 'b') => Q2
  case (Q1, 'a') => Q4
  case (Q1, 'b') => Q2
  case (Q2, 'a') => Q3
  case (Q2, 'b') => Q2
  case (Q3, 'a') => Q4
  case (Q3, 'b') => Q0
  case (Q4, 'a') => Q4
  case (Q4, 'b') => Q4
}

val dfa = DFA(Q0, delta, Set[State](Q4))

dfa.accepts("bbabaab".toList)
dfa.accepts("baba".toList)
dfa.accepts("bbabaa".toList)

