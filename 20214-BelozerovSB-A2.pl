item("THE LEGEND OF ZELDA: OCARINA OF TIME", "Action Adventure, ", "Nintendo", 1998).
item("TONY HAWK'S PRO SKATER 2", "Sports ", "Neversoft Entertainment", 2000).
item("GRAND THEFT AUTO IV", "Action Adventure", "Rockstar Games", 2008).
item("THE HOUSE IN FATA MORGANA - DREAMS OF THE REVENANTS EDITION ", "Visual Novel", "HuneX", 2021).
item("SOULCALIBUR", "Fighting", "Namco", 1999).
item("SUPER MARIO GALAXY", "Platformer", "Nintendo", 2007).
item("Red Dead Redemption 2", "Action Adventure", "Rockstar Games", 2018).
item("THE LEGEND OF ZELDA: BREATH OF THE WILD", "Action Adventure", "Nintendo", 2017).
item("PERFECT DARK", "Shooter", "Rare Ltd.", 2000).
item("DISCO ELYSIUM: THE FINAL CUT", "Role-Playing Game", "ZA/UM", 2021).
item("METROID PRIME", "Shooter", "Nintendo", 2002).
item("GRAND THEFT AUTO III", "Action Adventure", "Rockstar Games", 2001).
item("NFL 2K1", "Action Adventure", "Rockstar North", 2008).
item("SUPER MARIO ODYSSEY", "Platformer", "Nintendo", 2017).
item("HALF-LIFE 2", "Action Adventure", "Valve Software", 2004).
item("BIOSHOCK", "Action Adventure", "2K", 2007).
item("GOLDENEYE 007", "Shooter", "Rare Ltd", 1997).
item("UNCHARTED 2: AMONG THIEVES", "Action Adventure", "Naughty Dog", 2009).
item("RESIDENT EVIL 4", "Horror", "Capcom", 2005).
item("BATMAN: ARKHAM CITY", "Action Adventure", "Rocksteady Studios", 2011).
item("TEKKEN 3", "Fighting", "Namco", 1998).
item("MASS EFFECT 2", "Role-Playing Game", "BioWare", 2010).
item("THE LEGEND OF ZELDA: TWILIGHT PRINCESS", "Action Adventure", "Nintendo", 2006).
item("THE ELDER SCROLLS V: SKYRIM", " Role-Playing Games", " Bethesda Game Studios", 2011).
item("HALF-LIFE", "Shooter,", "Valve Software", 1998).

find :- write("Do you want to search something (yes/no)?\n"),
    read_string(user_input, "\n", "", _, Val), answer(Val).

    answer(Val) :- Val == "yes", search, !, nl.
    answer(Val) :- Val == "no", !, writeln("Bye! Have a nice day!\n").
    answer(_):-find.

search :- write("Welcome! You are in the 'Best 25 Videogames of all the time' list!\nPlease select search parameter:\n"),
    write("1 - The name of the Videoame\n"),
    write("2 - The Game Genre\n"),
    write("3 - The Developer\n"),
    write("4 - Year of Release\n"),
    read_string(user_input, "\n", "", _, Num),
    search_by_param(Num).

search_by_param("1") :- !,
    write("You have chosen to search by name of the Videoame.\n"),
    write("Please enter the full name of the Videogame in capital letters: "),
    read_string(user_input, "\n", "", _, Input),
    name(Input), nl.

search_by_param("2") :- !,
    write("You have chosen to search by the game genre.\n"),
    write("Please enter the genre: "),
    read_string(user_input, "\n", "", _, Input),
    genre(Input), nl.

search_by_param("3") :- !,
    write("You have chosen to search by the game developer.\n"),
    write("Please enter the name of a company: "),
    read_string(user_input, "\n", "", _, Input),
    company(Input), nl.

search_by_param("4") :- !,
    write("You have chosen to search by year of release.\n"),
    write("Please enter the lower bound: "),
    read_string(user_input, "\n", "", _, Left),
    write("Please enter the upper bound: "),
    read_string(user_input, "\n", "", _, Right),
    bounds(Left,Right), nl.

search_by_param(_) :- write("No such parameter!\n"), search.



name(P) :- item(P, Genre, Company, Year),
    writeln("===================================="),
    
    write("Name: "), writeln(P),
    write("Genre: "), writeln(Genre),
    write("Developer: "), writeln(Company),
    write("Released in "), write(Year), writeln(" year"),
    
    writeln("===================================="),
    fail,nl.
name(P) :- \+ item(P, _, _, _), !, write("Nothing found!\n"),fail,nl.

genre(P) :-
    item(Name, P, Company, Year),
    writeln("===================================="),
    
    write("Name: "), writeln(Name),
    write("Genre: "), writeln(P),
    write("Developer: "), writeln(Company),
    write("Released in "), write(Year), writeln(" year"),
   
    writeln("===================================="),
    fail,nl.
genre(P) :- \+ item(_, P, _, _), !, write("Nothing found!\n"),fail,nl.

company(P) :-
    item(Name, Genre, P, Year),
    writeln("===================================="),
    
    write("Name: "), writeln(Name),
    write("Genre: "), writeln(Genre),
    write("Developer: "), writeln(P),
    write("Released in "), write(Year), writeln(" year"),
    
    writeln("===================================="),
    fail,nl.
company(P) :- \+ item(_, _, P, _), !, write("Nothing found!\n"),fail,nl.

bounds(Left,Right):- atom_number(Left,NumLeft), atom_number(Right,NumRight), years(NumLeft,NumRight).
bounds(Left,Right):- atom_number(Left,NumLeft), \+atom_number(Right,_), years(NumLeft,2021).
bounds(Left,Right):- \+atom_number(Left,_), atom_number(Right,NumRight), years(1998,NumRight).
bounds(Left,Right):- \+atom_number(Left,_), \+atom_number(Right,_), years(1998,2021).

years(Left,Right) :- between(Left,Right,P), item(Name, Genre, Company, P),
    writeln("===================================="),
    
    write("Name: "), writeln(Name),
    write("Genre: "), writeln(Genre),
    write("Developer: "), writeln(Company),
    write("Released in "), write(P), writeln(" year"),
    
    writeln("===================================="),
    fail,nl.
years(Left,Right) :- between(Left,Right,P),\+item(_, _, _, P), !, write("Nothing found!\n"),fail,nl.