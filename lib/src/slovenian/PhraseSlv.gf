concrete PhraseSlv of Phrase = CatSlv ** open Prelude, ResSlv in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc ! Sg} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc ! Sg} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! Masc ! Sg} ;

    UttNP np = {s = np.s ! Nom} ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Indef ! Nom ! Sg} ;
    UttCard n = {s = n.s ! Fem ! Nom} ;
    UttAP ap = {s = ap.s ! Indef ! Masc ! Nom ! Sg} ;
    UttInterj i = i ;

    NoPConj = {s = []} ;

    NoVoc = {s = []} ;

}