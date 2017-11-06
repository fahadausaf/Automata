#include <set>
#include <map>
#include <iostream>

using namespace std;

template<typename T>
class DFA{
public:
  explicit DFA(int initial, bool isfinal);
  ~DFA(void);
  void add_state(int s, bool isFinal);
  void add_transition(int src, T input, int dest);
  bool is_accepting();
  void reset();
  int input(T inp);
  int state();

private:
  int m_initial;
  int m_state;
  set<int> m_states;
  set<int> m_final_states;
  map<pair<int,T>,int> m_transitions;
};

template<typename T>
DFA<T>::DFA(int initial, bool isfinal)
{
	this->m_initial = this->m_state = initial;
	add_state(initial, isfinal);
	add_state(-1, false); // invalid dead state
}

template<typename T>
DFA<T>::~DFA(void)
{
}

template<typename T>
void DFA<T>::add_transition(int src, T input, int dest)
{
	m_transitions.insert(pair<pair<int,T>, int>(pair<int,T>(src, input), dest));
}

template<typename T>
void DFA<T>::add_state(int s, bool isfinal)
{
	m_states.insert(s);
	if(isfinal) m_final_states.insert(s);
}

int main(){
  cout << "DFA" << endl;

  DFA<char> dfa(0, false);

  dfa.add_state(1, false);
  cout << "State 1 added" << endl;
	dfa.add_state(2, true);
  cout << "State 2 added" << endl;
	dfa.add_state(3, true);
  cout << "State 3 added" << endl;
	dfa.add_transition(0,'a',1);
  cout << "State 0, a, State 1" << endl;
	dfa.add_transition(1,'b',2);
  cout << "State 1, b, State 2" << endl;
	dfa.add_transition(1,'c',3);
  cout << "State 1, c, State 3" << endl;

  cout << "DFA Created" << endl;

  return 0;
}
