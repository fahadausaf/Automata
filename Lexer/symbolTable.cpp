#include<iostream>
#include<cstring>
#include <sstream>
#include <iterator>
using namespace std;

struct Word {
  char* word_name;
  int word_type;
  struct Word* next;
};

enum word_state {
  LOOKUP = 0,
  VERB = 1,
  ADJ = 2,
  ADV = 3,
  NOUN = 4,
  PREP = 5,
  PRON = 6,
  CONJ = 7,
  EXIT
};

struct Word *word_list; //first element in word list

int lookup_word(char *word){
  struct Word *wp = word_list;

  //search down the list looking for the word_list
  for(; wp; wp = wp->next){
    if(strcmp(wp->word_name, word) == 0)
      return wp->word_type;
  }

  return 0;
}

int insert_word(int type, char *word){
  if(lookup_word(word) != 0){
    cout << "!!! warning: word " << word << " already defined \n";
    return 0;
  }

  Word* w = new Word;
  w->word_type = type;
  w->word_name = (char *) malloc(strlen(word)+1);
  strcpy(w->word_name, word);
  w->next = word_list;
  word_list = w;
  return 1;
}

int add_word(int type, char *word){
  struct Word *wp;

  if(lookup_word(word) != 0){
    cout << "!!! warning: word " << word << " already defined \n";
    return 0;
  }

  wp = (struct Word *) malloc(sizeof(struct Word));
  wp->next = word_list;

  //have to copy the word itself as well

  wp->word_name = (char *) malloc(strlen(word)+1);
  strcpy(wp->word_name, word);
  wp->word_type = type;
  word_list = wp;
  return 1;
}

int main(){
  using namespace std;
    string sentence = "And I feel fine...";
    istringstream iss(sentence);
    copy(istream_iterator<string>(iss),
         istream_iterator<string>(),
         ostream_iterator<string>(cout, "\n"));
  return 0;
}
