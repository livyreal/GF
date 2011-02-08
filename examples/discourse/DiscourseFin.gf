--# -path=.:alltenses

concrete DiscourseFin of Discourse = 
  LexiconFin,
  NounFin, VerbFin - [SlashV2VNP,SlashVV],
  AdjectiveFin, AdverbFin,  
  StructuralFin - [nobody_NP,nothing_NP],
  TenseX
** open SyntaxFin, (P = ParadigmsFin), (R = ParamX), Prelude in {

lincat
  Clause  = {subj : NP ; vp : VP} ;
  Part    = Adv ;

lin
  ClauseS part temp pol cl = 
    mkS temp pol (mkCl (mkNP cl.subj part) cl.vp) ;
  SubjKinS part temp pol cl = 
    mkS temp pol (mkCl (mkNP (mkNP cl.subj (kin.s ! pol.p)) part) cl.vp) ;
  VerbKinS part temp pol cl = 
    mkS temp pol (mkCl (mkNP cl.subj part) (mkVP cl.vp (kin.s ! pol.p))) ;
  AdvKinS  part temp pol adv cl = 
    mkS temp pol (mkCl (mkNP cl.subj part) (mkVP (mkVP cl.vp adv) (kin.s ! pol.p))) ;
  PreAdvS part temp pol adv cl = 
    mkS adv (mkS part (mkS temp pol (mkCl cl.subj cl.vp))) ;
  PreAdvKinS part temp pol adv cl = 
    mkS adv (mkS part (mkS (kin.s ! pol.p) (mkS temp pol (mkCl cl.subj cl.vp)))) ;
  PreAdvSubjKinS  part temp pol adv cl = 
    mkS adv (mkS part (mkS temp pol (mkCl (mkNP cl.subj (kin.s ! pol.p)) cl.vp))) ;
  PreAdvVerbKinS  part temp pol adv cl = 
    mkS adv (mkS part (mkS temp pol (mkCl cl.subj (mkVP cl.vp (kin.s ! pol.p))))) ;
  PreAdvAdvKinS  part temp pol adv1 adv2 cl = 
    mkS adv1 (mkS part (mkS temp pol (mkCl cl.subj (mkVP (mkVP cl.vp adv2) (kin.s ! pol.p))))) ;

  PredClause subj v = {subj = subj ; vp = v} ;

  noPart     = P.mkAdv [] ;
  han_Part   = P.mkAdv (glueTok "han") ;
  pa_Part    = P.mkAdv (glueTok "pa") ;
  pas_Part   = P.mkAdv (glueTok "pas") ;
  ko_Part    = P.mkAdv (glueTok "ko") ;
  kos_Part   = P.mkAdv (glueTok "kos") ;
  kohan_Part = P.mkAdv (glueTok "kohan") ;
  pahan_Part = P.mkAdv (glueTok "pahan") ;


oper 
  kin : {s : R.Polarity => Adv}  = 
    {s = table {R.Pos => P.mkAdv (glueTok "kin") ; R.Neg => P.mkAdv (glueTok "kaan")}} ;

  glueTok : Str -> Str = \s -> "&+" ++ s ;

}
