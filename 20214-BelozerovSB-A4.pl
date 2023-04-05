/*
To use the programm just type the "therapist".
Then answer the questions.
If you wanr to exit, just type bye
*/

:- use_module('20214-BelozerovSB-A4_module1').
:- dynamic person/1.

therapist :- writeln("Please, tell me about your problem..."),questions.

in_list(Num,X,Words):-length(Words,Len),pattern(Num,X,Len), member(X,Words).

questions :- read_string(user_input, "\n", "\r", _, Input),
    string_lower(Input,Low),
    split_string(Low, "\s", ",.", Words),
    in_list(Num,X,Words),cases(Num,X),!.

cases(1,_):-write("Bye! I hope I've helped you."),!.
cases(2,_):-writeln("How long have you been feeling this way?"),questions.
cases(3,_):-writeln("Do you afraid of such strong feelings?"),questions.
cases(4,_):-writeln("It's very important topic, continue please..."),questions.
cases(5,_):-writeln("What are you feeling right now? This negative emotion yet?"),questions.
cases(6,_):-writeln("Please, tell me more about this..."),questions.
cases(7,_):-writeln("I think you're winding yourself up too much. You should let this situation go."),questions.
cases(8,_):-writeln("Could you give me some examples? When was the last time this situation happened?"),questions.
cases(9,X):-assertz(person(X)),
    writeln("Tell me more about your relationtship"),questions.
cases(10, _) :- \+ person(_), !,
    writeln("Uhm, I see... If there is anything you could add, continue please."),questions.
cases(10, _) :- write("Hm, you've mentioned your "),
    person(X), write(X), writeln(". Is there anything else you can say?"),
    retract(person(X)),questions.
