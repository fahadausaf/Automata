// DFAs and NFAs based on Scala's partial functions
import scala.util.Try


// type abbreviation for partial functions
type :=>[A, B] = PartialFunction[A, B]

// class for DFAs
case class DFA[A, C](start: A,                // starting state
                     delta: (A, C) :=> A,     // transition
                     fins:  A => Boolean) {   // final states

  // given a state and a "string", what is the next
  // state, if there is any?
  def deltas(q: A, s: List[C]) : A = s match {
    case Nil => q
    case c::cs => deltas(delta(q, c), cs)
  }

  // is a "string" accepted by an DFA?
  def accepts(s: List[C]) : Boolean =
    Try(fins(deltas(start, s))) getOrElse false

}

// some states for test cases
abstract class State
case object Q0 extends State
case object Q1 extends State
case object Q2 extends State
case object Q3 extends State
case object Q4 extends State

val delta : (State, Char) :=> State ={
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
