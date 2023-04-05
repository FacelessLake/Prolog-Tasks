/*
 *Butsie is a brown cat, Cornie is a black cat, Mac is a red cat.
  Flash, Rover and Spot are dogs.
  Flash is a spotted dog, Rover is a red dog, and Spot is a white dog.

  Tom owns any pet that is either brown or black.
  Kate owns all non-white dogs, not belonging to Tom.
  All pets Kate or Tom owns are pedigree animals.

  Alan owns Mac if Kate does not own Butsie and Spot is not a pedigree
  animal.
*/

cat(butsie).
cat(cornie).
cat(mac).
dog(rover).
dog(flash).
dog(spot).

color(butsie,brown).
color(cornie, black).
color(mac, red).
color(rover, red).
color(flash,spotted).
color(spot, white).

owns(tom,X):- (cat(X);dog(X)), (color(X,black);color(X,brown)).
owns(kate,X):- dog(X), not(owns(tom,X)), not(color(X,white)).
owns(alan,mac) :- not(owns(kate, butsue)),not(pedigree(spot)).

pedigree(X) :- owns(kate,X);owns(tom,X).

homeless(X):- (cat(X);dog(X)),not(owns_,X)).

echo([]).
echo([I]) :- format('~w\n', [I]), !.
echo([I|Is]) :- format('~w, ', [I]), echo(Is).

main(_) :-
	writeln('Tom owns:'),
	(findall(Pet1, owns(tom, Pet1), TomOwns), echo(TomOwns)),
	writeln('\nKate owns:'),
	(findall(Pet2, owns(kate, Pet2), KateOwns), echo(KateOwns)).
:- initialization(main, main).
