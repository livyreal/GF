-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
 module GF.Source.ParGF (pGrammar, pModDef, pOldGrammar, pExp, myLexer) where --H
import GF.Source.AbsGF       --H
import GF.Source.LexGF       --H
import GF.Infra.Ident        --H
import GF.Data.ErrM          --H
}

%name pGrammar Grammar
%name pModDef ModDef
%name pOldGrammar OldGrammar
%name pExp Exp

-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype { Token }

%token 
 ';' { PT _ (TS ";") }
 '=' { PT _ (TS "=") }
 '{' { PT _ (TS "{") }
 '}' { PT _ (TS "}") }
 '(' { PT _ (TS "(") }
 ')' { PT _ (TS ")") }
 ':' { PT _ (TS ":") }
 '->' { PT _ (TS "->") }
 '**' { PT _ (TS "**") }
 ',' { PT _ (TS ",") }
 '[' { PT _ (TS "[") }
 ']' { PT _ (TS "]") }
 '-' { PT _ (TS "-") }
 '.' { PT _ (TS ".") }
 '|' { PT _ (TS "|") }
 '%' { PT _ (TS "%") }
 '?' { PT _ (TS "?") }
 '<' { PT _ (TS "<") }
 '>' { PT _ (TS ">") }
 '@' { PT _ (TS "@") }
 '!' { PT _ (TS "!") }
 '*' { PT _ (TS "*") }
 '+' { PT _ (TS "+") }
 '++' { PT _ (TS "++") }
 '\\' { PT _ (TS "\\") }
 '=>' { PT _ (TS "=>") }
 '_' { PT _ (TS "_") }
 '$' { PT _ (TS "$") }
 '/' { PT _ (TS "/") }
 'Lin' { PT _ (TS "Lin") }
 'PType' { PT _ (TS "PType") }
 'Str' { PT _ (TS "Str") }
 'Strs' { PT _ (TS "Strs") }
 'Tok' { PT _ (TS "Tok") }
 'Type' { PT _ (TS "Type") }
 'abstract' { PT _ (TS "abstract") }
 'case' { PT _ (TS "case") }
 'cat' { PT _ (TS "cat") }
 'concrete' { PT _ (TS "concrete") }
 'data' { PT _ (TS "data") }
 'def' { PT _ (TS "def") }
 'flags' { PT _ (TS "flags") }
 'fn' { PT _ (TS "fn") }
 'fun' { PT _ (TS "fun") }
 'grammar' { PT _ (TS "grammar") }
 'in' { PT _ (TS "in") }
 'include' { PT _ (TS "include") }
 'incomplete' { PT _ (TS "incomplete") }
 'instance' { PT _ (TS "instance") }
 'interface' { PT _ (TS "interface") }
 'let' { PT _ (TS "let") }
 'lin' { PT _ (TS "lin") }
 'lincat' { PT _ (TS "lincat") }
 'lindef' { PT _ (TS "lindef") }
 'lintype' { PT _ (TS "lintype") }
 'of' { PT _ (TS "of") }
 'open' { PT _ (TS "open") }
 'oper' { PT _ (TS "oper") }
 'out' { PT _ (TS "out") }
 'package' { PT _ (TS "package") }
 'param' { PT _ (TS "param") }
 'pattern' { PT _ (TS "pattern") }
 'pre' { PT _ (TS "pre") }
 'printname' { PT _ (TS "printname") }
 'resource' { PT _ (TS "resource") }
 'reuse' { PT _ (TS "reuse") }
 'strs' { PT _ (TS "strs") }
 'table' { PT _ (TS "table") }
 'tokenizer' { PT _ (TS "tokenizer") }
 'transfer' { PT _ (TS "transfer") }
 'union' { PT _ (TS "union") }
 'var' { PT _ (TS "var") }
 'variants' { PT _ (TS "variants") }
 'where' { PT _ (TS "where") }
 'with' { PT _ (TS "with") }

L_ident  { PT _ (TV $$) }
L_integ  { PT _ (TI $$) }
L_quoted { PT _ (TL $$) }
L_doubl  { PT _ (TD $$) }
L_LString { PT _ (T_LString $$) }
L_err    { _ }


%%

Ident   :: { Ident }   : L_ident  { identC $1 } --H
Integer :: { Integer } : L_integ  { (read $1) :: Integer }
String  :: { String }  : L_quoted { $1 }
Double  :: { Double }  : L_doubl  { (read $1) :: Double }
LString    :: { LString} : L_LString { LString ($1)}

Grammar :: { Grammar }
Grammar : ListModDef { Gr (reverse $1) } 


ListModDef :: { [ModDef] }
ListModDef : {- empty -} { [] } 
  | ListModDef ModDef { flip (:) $1 $2 }


ModDef :: { ModDef }
ModDef : ModDef ';' { $1 } 
  | 'grammar' Ident '=' '{' 'abstract' '=' Ident ';' ListConcSpec '}' { MMain $2 $7 $9 }
  | ComplMod ModType '=' ModBody { MModule $1 $2 $4 }


ConcSpec :: { ConcSpec }
ConcSpec : Ident '=' ConcExp { ConcSpec $1 $3 } 


ListConcSpec :: { [ConcSpec] }
ListConcSpec : {- empty -} { [] } 
  | ConcSpec { (:[]) $1 }
  | ConcSpec ';' ListConcSpec { (:) $1 $3 }


ConcExp :: { ConcExp }
ConcExp : Ident ListTransfer { ConcExp $1 (reverse $2) } 


ListTransfer :: { [Transfer] }
ListTransfer : {- empty -} { [] } 
  | ListTransfer Transfer { flip (:) $1 $2 }


Transfer :: { Transfer }
Transfer : '(' 'transfer' 'in' Open ')' { TransferIn $4 } 
  | '(' 'transfer' 'out' Open ')' { TransferOut $4 }


ModType :: { ModType }
ModType : 'abstract' Ident { MTAbstract $2 } 
  | 'resource' Ident { MTResource $2 }
  | 'interface' Ident { MTInterface $2 }
  | 'concrete' Ident 'of' Ident { MTConcrete $2 $4 }
  | 'instance' Ident 'of' Ident { MTInstance $2 $4 }
  | 'transfer' Ident ':' Open '->' Open { MTTransfer $2 $4 $6 }


ModBody :: { ModBody }
ModBody : Extend Opens '{' ListTopDef '}' { MBody $1 $2 (reverse $4) } 
  | ListIncluded { MNoBody $1 }
  | Included 'with' ListOpen { MWith $1 $3 }
  | Included 'with' ListOpen '**' Opens '{' ListTopDef '}' { MWithBody $1 $3 $5 (reverse $7) }
  | ListIncluded '**' Included 'with' ListOpen { MWithE $1 $3 $5 }
  | ListIncluded '**' Included 'with' ListOpen '**' Opens '{' ListTopDef '}' { MWithEBody $1 $3 $5 $7 (reverse $9) }
  | 'reuse' Ident { MReuse $2 }
  | 'union' ListIncluded { MUnion $2 }


ListTopDef :: { [TopDef] }
ListTopDef : {- empty -} { [] } 
  | ListTopDef TopDef { flip (:) $1 $2 }


Extend :: { Extend }
Extend : ListIncluded '**' { Ext $1 } 
  | {- empty -} { NoExt }


ListOpen :: { [Open] }
ListOpen : {- empty -} { [] } 
  | Open { (:[]) $1 }
  | Open ',' ListOpen { (:) $1 $3 }


Opens :: { Opens }
Opens : {- empty -} { NoOpens } 
  | 'open' ListOpen 'in' { OpenIn $2 }


Open :: { Open }
Open : Ident { OName $1 } 
  | '(' QualOpen Ident ')' { OQualQO $2 $3 }
  | '(' QualOpen Ident '=' Ident ')' { OQual $2 $3 $5 }


ComplMod :: { ComplMod }
ComplMod : {- empty -} { CMCompl } 
  | 'incomplete' { CMIncompl }


QualOpen :: { QualOpen }
QualOpen : {- empty -} { QOCompl } 
  | 'incomplete' { QOIncompl }
  | 'interface' { QOInterface }


ListIncluded :: { [Included] }
ListIncluded : {- empty -} { [] } 
  | Included { (:[]) $1 }
  | Included ',' ListIncluded { (:) $1 $3 }


Included :: { Included }
Included : Ident { IAll $1 } 
  | Ident '[' ListIdent ']' { ISome $1 $3 }
  | Ident '-' '[' ListIdent ']' { IMinus $1 $4 }


Def :: { Def }
Def : ListName ':' Exp { DDecl $1 $3 } 
  | ListName '=' Exp { DDef $1 $3 }
  | Name ListPatt '=' Exp { DPatt $1 $2 $4 }
  | ListName ':' Exp '=' Exp { DFull $1 $3 $5 }


TopDef :: { TopDef }
TopDef : 'cat' ListCatDef { DefCat $2 } 
  | 'fun' ListFunDef { DefFun $2 }
  | 'data' ListFunDef { DefFunData $2 }
  | 'def' ListDef { DefDef $2 }
  | 'data' ListDataDef { DefData $2 }
  | 'transfer' ListDef { DefTrans $2 }
  | 'param' ListParDef { DefPar $2 }
  | 'oper' ListDef { DefOper $2 }
  | 'lincat' ListPrintDef { DefLincat $2 }
  | 'lindef' ListDef { DefLindef $2 }
  | 'lin' ListDef { DefLin $2 }
  | 'printname' 'cat' ListPrintDef { DefPrintCat $3 }
  | 'printname' 'fun' ListPrintDef { DefPrintFun $3 }
  | 'flags' ListFlagDef { DefFlag $2 }
  | 'printname' ListPrintDef { DefPrintOld $2 }
  | 'lintype' ListDef { DefLintype $2 }
  | 'pattern' ListDef { DefPattern $2 }
  | 'package' Ident '=' '{' ListTopDef '}' ';' { DefPackage $2 (reverse $5) }
  | 'var' ListDef { DefVars $2 }
  | 'tokenizer' Ident ';' { DefTokenizer $2 }


CatDef :: { CatDef }
CatDef : Ident ListDDecl { SimpleCatDef $1 (reverse $2) } 
  | '[' Ident ListDDecl ']' { ListCatDef $2 (reverse $3) }
  | '[' Ident ListDDecl ']' '{' Integer '}' { ListSizeCatDef $2 (reverse $3) $6 }


FunDef :: { FunDef }
FunDef : ListIdent ':' Exp { FunDef $1 $3 } 


DataDef :: { DataDef }
DataDef : Ident '=' ListDataConstr { DataDef $1 $3 } 


DataConstr :: { DataConstr }
DataConstr : Ident { DataId $1 } 
  | Ident '.' Ident { DataQId $1 $3 }


ListDataConstr :: { [DataConstr] }
ListDataConstr : {- empty -} { [] } 
  | DataConstr { (:[]) $1 }
  | DataConstr '|' ListDataConstr { (:) $1 $3 }


ParDef :: { ParDef }
ParDef : Ident '=' ListParConstr { ParDefDir $1 $3 } 
  | Ident '=' '(' 'in' Ident ')' { ParDefIndir $1 $5 }
  | Ident { ParDefAbs $1 }


ParConstr :: { ParConstr }
ParConstr : Ident ListDDecl { ParConstr $1 (reverse $2) } 


PrintDef :: { PrintDef }
PrintDef : ListName '=' Exp { PrintDef $1 $3 } 


FlagDef :: { FlagDef }
FlagDef : Ident '=' Ident { FlagDef $1 $3 } 


ListDef :: { [Def] }
ListDef : Def ';' { (:[]) $1 } 
  | Def ';' ListDef { (:) $1 $3 }


ListCatDef :: { [CatDef] }
ListCatDef : CatDef ';' { (:[]) $1 } 
  | CatDef ';' ListCatDef { (:) $1 $3 }


ListFunDef :: { [FunDef] }
ListFunDef : FunDef ';' { (:[]) $1 } 
  | FunDef ';' ListFunDef { (:) $1 $3 }


ListDataDef :: { [DataDef] }
ListDataDef : DataDef ';' { (:[]) $1 } 
  | DataDef ';' ListDataDef { (:) $1 $3 }


ListParDef :: { [ParDef] }
ListParDef : ParDef ';' { (:[]) $1 } 
  | ParDef ';' ListParDef { (:) $1 $3 }


ListPrintDef :: { [PrintDef] }
ListPrintDef : PrintDef ';' { (:[]) $1 } 
  | PrintDef ';' ListPrintDef { (:) $1 $3 }


ListFlagDef :: { [FlagDef] }
ListFlagDef : FlagDef ';' { (:[]) $1 } 
  | FlagDef ';' ListFlagDef { (:) $1 $3 }


ListParConstr :: { [ParConstr] }
ListParConstr : {- empty -} { [] } 
  | ParConstr { (:[]) $1 }
  | ParConstr '|' ListParConstr { (:) $1 $3 }


ListIdent :: { [Ident] }
ListIdent : Ident { (:[]) $1 } 
  | Ident ',' ListIdent { (:) $1 $3 }


Name :: { Name }
Name : Ident { IdentName $1 } 
  | '[' Ident ']' { ListName $2 }


ListName :: { [Name] }
ListName : Name { (:[]) $1 } 
  | Name ',' ListName { (:) $1 $3 }


LocDef :: { LocDef }
LocDef : ListIdent ':' Exp { LDDecl $1 $3 } 
  | ListIdent '=' Exp { LDDef $1 $3 }
  | ListIdent ':' Exp '=' Exp { LDFull $1 $3 $5 }


ListLocDef :: { [LocDef] }
ListLocDef : {- empty -} { [] } 
  | LocDef { (:[]) $1 }
  | LocDef ';' ListLocDef { (:) $1 $3 }


Exp6 :: { Exp }
Exp6 : Ident { EIdent $1 } 
  | '{' Ident '}' { EConstr $2 }
  | '%' Ident '%' { ECons $2 }
  | Sort { ESort $1 }
  | String { EString $1 }
  | Integer { EInt $1 }
  | Double { EFloat $1 }
  | '?' { EMeta }
  | '[' ']' { EEmpty }
  | 'data' { EData }
  | '[' Ident Exps ']' { EList $2 $3 }
  | '[' String ']' { EStrings $2 }
  | '{' ListLocDef '}' { ERecord $2 }
  | '<' ListTupleComp '>' { ETuple $2 }
  | '(' 'in' Ident ')' { EIndir $3 }
  | '<' Exp ':' Exp '>' { ETyped $2 $4 }
  | '(' Exp ')' { $2 }
  | LString { ELString $1 }


Exp5 :: { Exp }
Exp5 : Exp5 '.' Label { EProj $1 $3 } 
  | '{' Ident '.' Ident '}' { EQConstr $2 $4 }
  | '%' Ident '.' Ident { EQCons $2 $4 }
  | Exp6 { $1 }


Exp4 :: { Exp }
Exp4 : Exp4 Exp5 { EApp $1 $2 } 
  | 'table' '{' ListCase '}' { ETable $3 }
  | 'table' Exp6 '{' ListCase '}' { ETTable $2 $4 }
  | 'table' Exp6 '[' ListExp ']' { EVTable $2 $4 }
  | 'case' Exp 'of' '{' ListCase '}' { ECase $2 $5 }
  | 'variants' '{' ListExp '}' { EVariants $3 }
  | 'pre' '{' Exp ';' ListAltern '}' { EPre $3 $5 }
  | 'strs' '{' ListExp '}' { EStrs $3 }
  | Ident '@' Exp6 { EConAt $1 $3 }
  | Exp5 { $1 }
  | 'Lin' Ident { ELin $2 }


Exp3 :: { Exp }
Exp3 : Exp3 '!' Exp4 { ESelect $1 $3 } 
  | Exp3 '*' Exp4 { ETupTyp $1 $3 }
  | Exp3 '**' Exp4 { EExtend $1 $3 }
  | Exp4 { $1 }


Exp1 :: { Exp }
Exp1 : Exp2 '+' Exp1 { EGlue $1 $3 } 
  | Exp2 { $1 }


Exp :: { Exp }
Exp : Exp1 '++' Exp { EConcat $1 $3 } 
  | '\\' ListBind '->' Exp { EAbstr $2 $4 }
  | '\\' '\\' ListBind '=>' Exp { ECTable $3 $5 }
  | Decl '->' Exp { EProd $1 $3 }
  | Exp3 '=>' Exp { ETType $1 $3 }
  | 'let' '{' ListLocDef '}' 'in' Exp { ELet $3 $6 }
  | 'let' ListLocDef 'in' Exp { ELetb $2 $4 }
  | Exp3 'where' '{' ListLocDef '}' { EWhere $1 $4 }
  | 'fn' '{' ListEquation '}' { EEqs $3 }
  | 'in' Exp5 String { EExample $2 $3 }
  | Exp1 { $1 }


Exp2 :: { Exp }
Exp2 : Exp3 { $1 } 


ListExp :: { [Exp] }
ListExp : {- empty -} { [] } 
  | Exp { (:[]) $1 }
  | Exp ';' ListExp { (:) $1 $3 }


Exps :: { Exps }
Exps : {- empty -} { NilExp } 
  | Exp6 Exps { ConsExp $1 $2 }


Patt2 :: { Patt }
Patt2 : '_' { PW } 
  | Ident { PV $1 }
  | '{' Ident '}' { PCon $2 }
  | Ident '.' Ident { PQ $1 $3 }
  | Integer { PInt $1 }
  | Double { PFloat $1 }
  | String { PStr $1 }
  | '{' ListPattAss '}' { PR $2 }
  | '<' ListPattTupleComp '>' { PTup $2 }
  | '(' Patt ')' { $2 }


Patt1 :: { Patt }
Patt1 : Ident ListPatt { PC $1 $2 } 
  | Ident '.' Ident ListPatt { PQC $1 $3 $4 }
  | Patt2 '*' { PRep $1 }
  | Ident '@' Patt2 { PAs $1 $3 }
  | '-' Patt2 { PNeg $2 }
  | Patt2 { $1 }


Patt :: { Patt }
Patt : Patt '|' Patt1 { PDisj $1 $3 } 
  | Patt '+' Patt1 { PSeq $1 $3 }
  | Patt1 { $1 }


PattAss :: { PattAss }
PattAss : ListIdent '=' Patt { PA $1 $3 } 


Label :: { Label }
Label : Ident { LIdent $1 } 
  | '$' Integer { LVar $2 }


Sort :: { Sort }
Sort : 'Type' { Sort_Type } 
  | 'PType' { Sort_PType }
  | 'Tok' { Sort_Tok }
  | 'Str' { Sort_Str }
  | 'Strs' { Sort_Strs }


ListPattAss :: { [PattAss] }
ListPattAss : {- empty -} { [] } 
  | PattAss { (:[]) $1 }
  | PattAss ';' ListPattAss { (:) $1 $3 }


ListPatt :: { [Patt] }
ListPatt : Patt2 { (:[]) $1 } 
  | Patt2 ListPatt { (:) $1 $2 }


Bind :: { Bind }
Bind : Ident { BIdent $1 } 
  | '_' { BWild }


ListBind :: { [Bind] }
ListBind : {- empty -} { [] } 
  | Bind { (:[]) $1 }
  | Bind ',' ListBind { (:) $1 $3 }


Decl :: { Decl }
Decl : '(' ListBind ':' Exp ')' { DDec $2 $4 } 
  | Exp4 { DExp $1 }


TupleComp :: { TupleComp }
TupleComp : Exp { TComp $1 } 


PattTupleComp :: { PattTupleComp }
PattTupleComp : Patt { PTComp $1 } 


ListTupleComp :: { [TupleComp] }
ListTupleComp : {- empty -} { [] } 
  | TupleComp { (:[]) $1 }
  | TupleComp ',' ListTupleComp { (:) $1 $3 }


ListPattTupleComp :: { [PattTupleComp] }
ListPattTupleComp : {- empty -} { [] } 
  | PattTupleComp { (:[]) $1 }
  | PattTupleComp ',' ListPattTupleComp { (:) $1 $3 }


Case :: { Case }
Case : Patt '=>' Exp { Case $1 $3 } 


ListCase :: { [Case] }
ListCase : Case { (:[]) $1 } 
  | Case ';' ListCase { (:) $1 $3 }


Equation :: { Equation }
Equation : ListPatt '->' Exp { Equ $1 $3 } 


ListEquation :: { [Equation] }
ListEquation : {- empty -} { [] } 
  | Equation { (:[]) $1 }
  | Equation ';' ListEquation { (:) $1 $3 }


Altern :: { Altern }
Altern : Exp '/' Exp { Alt $1 $3 } 


ListAltern :: { [Altern] }
ListAltern : {- empty -} { [] } 
  | Altern { (:[]) $1 }
  | Altern ';' ListAltern { (:) $1 $3 }


DDecl :: { DDecl }
DDecl : '(' ListBind ':' Exp ')' { DDDec $2 $4 } 
  | Exp6 { DDExp $1 }


ListDDecl :: { [DDecl] }
ListDDecl : {- empty -} { [] } 
  | ListDDecl DDecl { flip (:) $1 $2 }


OldGrammar :: { OldGrammar }
OldGrammar : Include ListTopDef { OldGr $1 (reverse $2) } 


Include :: { Include }
Include : {- empty -} { NoIncl } 
  | 'include' ListFileName { Incl $2 }


FileName :: { FileName }
FileName : String { FString $1 } 
  | Ident { FIdent $1 }
  | '/' FileName { FSlash $2 }
  | '.' FileName { FDot $2 }
  | '-' FileName { FMinus $2 }
  | Ident FileName { FAddId $1 $2 }


ListFileName :: { [FileName] }
ListFileName : FileName ';' { (:[]) $1 } 
  | FileName ';' ListFileName { (:) $1 $3 }



{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map prToken (take 4 ts))

myLexer = tokens
}

