
// some states for test cases
abstract class State

case class NFA(startStates: Set[State], delta: (State, Char) => Set[State], finalStates: Set[State]) {
  def next(s: State, c: Char) : Set[State] =
    delta(s, c)

  def nexts(s: Set[State], c: Char) : Set[State] =
    s.flatMap(next(_, c))

  def deltas(s: Set[State], c: List[Char]) : Set[State] = c match {
    case Nil => s
    case c::cs => deltas(nexts(s, c), cs)
  }

  // Breadth-First-Search
  def accepts(c: List[Char]) : Boolean =
    finalStates.exists(deltas(startStates, c))


}

case object Q0 extends State
case object Q1 extends State
case object Q2 extends State

def delta(s: State, c: Char) : Set[State] = (s, c) match{
  case (Q0, 'a') => Set(Q1, Q2)
  case (Q0, 'b') => Set(Q0)
  case (Q1, 'a') => Set(Q1, Q2)
  case (Q1, 'b') => Set(Q0, Q1)
  case (_, _) => Set()
}

val startStates = Set[State](Q0)
val finalStates = Set[State](Q2)
val dfa = NFA(startStates, delta, finalStates)

dfa.accepts("bab".toList)
dfa.accepts("baba".toList)