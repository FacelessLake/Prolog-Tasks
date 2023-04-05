/*
How to use?
Just run the "expert" command and follow the instructions.
*/
gameclass(1,"Champion",[1,2,3]).
gameclass(2,"Ranger",[1,2,5]).
gameclass(3,"Magus",[1,2,6]).
gameclass(4,"Rogue",[1,2,8]).
gameclass(5,"Cleric",[1,3,4]).
gameclass(6,"Summoner",[1,3,5]).
gameclass(7,"Witch",[1,3,6]).
gameclass(8,"Oracle",[1,3,7,9]).
gameclass(9,"Sorcerer",[1,3,9]).
gameclass(10,"Bard",[1,4,9]).
gameclass(11,"Druid",[1,5]).
gameclass(12,"Wizard",[1,6]).
gameclass(13,"Monk",[1,9]).
gameclass(14,"Inventor",[2,5,6]).
gameclass(15,"Investigator",[2,6]).
gameclass(16,"Barbarian",[2,7]).
gameclass(17,"Swashbuckler",[2,8]).
gameclass(18,"Fighter",[2,9]).
gameclass(19,"Gunslinger",[2,9,8]).
gameclass(20,"Alchemist",[4,6,9]).


property(1, "use magic abilities").
property(2, "be good at weapons").
property(3, "have a bond with otherworldly forces").
property(4, "be more of support character rather then combat one").
property(5, "have a powerful companion").
property(6, "be really smart").
property(7, "can`t control their power properly").
property(8, "prefer elegance to brute force").
property(9, "be adaptive to any situation").

:- dynamic db_yes/1.
:- dynamic db_no/1.


yes(X) :- db_yes(X), !.
yes(X) :- not(no(X)), !,
    check_if(X).
no(X) :- db_no(X), !.

check_if(X) :- write("May your character "), write(X), writeln("?"),
    read_string(user_input, "\n", "", _, Reply),
    remember(Reply, X).

remember("yes", X) :- asserta(db_yes(X)).
remember("no", X) :- asserta(db_no(X)), fail.

class(X,Pr) :- gameclass(_, X, Pr),
    check_property(Pr).
class(X,Pr):- gameclass(_, X, Pr),
    \+ check_property(Pr),
    write("Nothing found!\n"),!,fail.

check_property([N | Property]) :- property(N, A),
    yes(A), check_property(Property).
check_property([]).

write_properties([N | Property ]):- property(N, A), write(A),
    write_remained(Property).
write_remained([N | Property]):- property(N, A),
    write(" and "),write(A),
    write_remained(Property).
write_remained([]).

choose_class :- retractall(db_yes(_)), retractall(db_no(_)),
    writeln("Please, answer the following questions with 'yes' or 'no':"),
    class(X,Pr),
    write("I think you should choose "),
    write(X), 
    write(", because you want to "),
    write_properties(Pr).

write_pr([N | Property ]):- property(N, A),
    write(" -"),
    writeln(A),
    write_pr(Property).
write_pr([]).

watch_class :- writeln("Please, choose number of class you want to learn about:"),
    write_class(1),
    read_string(user_input, "\n", "\r", _, Input),
    case_class(Input).

case_class(Input) :- atom_number(Input,Num),
    \+ gameclass(Num, _, _),
    writeln("Wrong number!"),
    nl,watch_class.
case_class(Input) :- atom_number(Input,Num),
    gameclass(Num, X, Pr),
    write(X),
    writeln(" has these traits:"),
    write_pr(Pr).

write_class(I):-gameclass(I,Name,_),
    write(I),write(". "),
    writeln(Name),
    X is I+1,
    write_class(X).
write_class(20):-!.

expert:- writeln("Welcome to the Pathfinder 2e class guide!"),
    writeln("What do you want?"),
    writeln("Type '1' to see all the classes"),
    writeln("Type '2' to use our helper for class choosing"),
    writeln("Type '3' to exit"),
    read_string(user_input, "\n", "\r", _, Input),
    case(Input).
    
case("1"):- watch_class,!.
case("2"):- choose_class,!.
case("3"):- writeln("Goodbye!"),!.
case(_):- writeln("Please, follow the instructions!"),nl,expert.
