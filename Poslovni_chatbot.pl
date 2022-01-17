proizvod('a110','racunala').
proizvod('b110','monitori').

tomi:-
    pocetak,
    odabirOpcije.
    

pocetak:-
         write("Lijep pozdrav. Moje ime je Tomi. Ja sam poslovni chatbot našeg
         poduzeca. Za pocetak mi recite svoje ime."),nl,
         read(UnosIme),
         write("Pozdrav "),
         write(UnosIme),
         write(" ."),nl.


odabirOpcije:-
              write("Želite li naruciti proizvod ili reklamirati proizvod?"),nl,
              read(Unos),
              (Unos='naruciti'->naruci,nl,!;
              (Unos='reklamirati'->reklamiraj,nl,!;
              (write("Ta naredba mi je nepoznata.Molim vas da budete precizniji!"),nl,odabirOpcije))).

naruci:-
        write("Koja kategorija proizvoda vas zanima?"),nl,
        read(Unos),
        provjeriKategoriju(Unos)->
        write("Zanimaju vas "),
        write(Unos),nl,
        write("Znate li možda koji proizvod konkretno zelite, ili bi ste htjeli nasu preporuku?"),nl,
        read(Unos2),
        (Unos2='preporuka'->preporuci(Unos),nl,!;
        (Unos2\='preporuka'->proizvodi(Unos2,Unos),nl))
        ;write("Zao nam je ali neprodajemo proizvode iz te kategorije!"),nl,nl,naruci.

provjeriKategoriju(Kategorija):-proizvod(_,Kategorija).

preporuci(Kategorija):-proizvod(_,Kategorija)->
                       write("Preporucamo vam "),proizvod(X,Kategorija),
                       write(X),nl,
                       nastaviKupnju(X,Kategorija).

proizvodi(Proizvod,Kategorija):-proizvod(Proizvod,Kategorija)->
                                write("Odabrali ste proizvod "),
                                write(Proizvod),
                                write(" iz kategorije "),
                                write(Kategorija),
                                write(" ."),nl,
                                nastaviKupnju(Proizvod,Kategorija)
                                ;write("Zao nam je ali trenutno nemamo takav proizvod."),nl,
                                write("Zelite li odabrati neki drugi proizvod ili biste htjeli nasu preporuku?"),nl,
                                read(Unos),
                                (Unos='preporuka'->preporuci(Kategorija),nl,!;
                                (Unos\='preporuka'->proizvodi(Unos,Kategorija),nl)).
                               
nastaviKupnju(Proizvod,Kategorija):-write("Zelite li kupiti taj proizvod?"),nl,
                                    read(Unos),
                                    (Unos='da'->kupiProizvod(Proizvod,Kategorija),nl,!;
                                    (Unos\='da'->
                                    write("Ne zelite kupiti proizvod, u redu."),nl)).
                                    
kupiProizvod(Proizvod,Kategorija):-write("Odlucili ste se za kupnju proizvoda "),
                                   write(Proizvod),
                                   write(" iz kategorije "),
                                   write(Kategorija),nl,
                                   write("Molimo vas da unesete ime i prezime primatelja: "),
                                   read(Primatelj),nl,
                                   write("Molimo vas da unesete adresu: "),
                                   read(Adresa),nl,
                                   write("Ukupna cijena je 150kn s poštarinom."),nl,
                                   write("Jeste li spremni potvrditi narudzbu?"),nl,
                                   read(Potvrda),
                                   (Potvrda='da'->zavrsiKupnju(Proizvod,Kategorija,Primatelj,Adresa),nl,!;
                                   (Potvrda\='da'->write("Odustali ste od kupnje."),nl)).

zavrsiKupnju(Proizvod,Kategorija,Primatelj,Adresa):-write("Prihvatili ste kupnju proizvoda."),nl,
                                                    write("Podaci o narudzbi:"),nl,
                                                    write("Proizvod: "),write(Proizvod),nl,
                                                    write("Kategorija: "),write(Kategorija),nl,
                                                    write("Primatelj: "),write(Primatelj),nl,
                                                    write("Adresa: "),write(Adresa),nl,
                                                    write("Prihvacate li kupnju proizvoda?"),
                                                    read(Potvrda),
                                                    (Potvrda='da'->write("Cestitamo, uspjesno ste narucili proizvod. Dovidenja."),nl,!;
                                                    (Potvrda\='da'->write("Odustali ste od kupnje proizvoda."),nl)).

reklamiraj:-
            write("Koji proizvod želite reklamirati?"),nl,read(Proizvod),nl,provjeriProizvod(Proizvod).
            
provjeriProizvod(Proizvod):-proizvod(Proizvod,_)->nl,nastaviReklamaciju(Proizvod);write("Nazalost nemamo takav proizvod."),nl,odabirOpcije.

nastaviReklamaciju(Proizvod):-write("Reklamirate proizvod "),write(Proizvod),write(" iz kategorije "),proizvod(Proizvod,Kategorija),write(Kategorija),write(" ."),nl,
                              write("Zao nam je sto imate problema s nasim proizvodom."),nl,
                              write("Koji tocno problem imate s proizvodom?"),nl,
                              read(Reklamacija),nl,
                              handlerReklamacija(Reklamacija).

handlerReklamacija(Reklamacija):-Reklamacija='neispravan_proizvod'->write("Zao nam je sto je vas kupljeni proizvod neispravan."),nl,
                                 write("Potruditi cemo se da kvaliteta nasih proizvoda bude na visoj razini!"),nl,nl;
                                 Reklamacija='narudzba_nije_dosla'->write("Hmm. Cekate li vasu narudzbu duze od tjedan dana?"),nl,
                                 read(Cekanje),nl,
                                 (Cekanje='da'->write("Zao nam je sto toliko dugo cekate narudzbu. Poslati cemo vam novi proizvod na vasu adresu!"),nl,!;
                                 (Cekanje='ne'->write("Narudzbe koje obavite kod nas u prosjeku pristignu kroz tjedan dana. Molimo vas da pricekate jos par dana."),
                                 nl)).
