--# -path=.:../scandinavian:../abstract:../../prelude

-- see: http://frodo.bruderhof.com/norskklassen/commonverbs.htm

concrete VerbsDan of VerbsDanAbs = CategoriesDan ** open ParadigmsDan in {

  flags optimize=values ;

  lin be_V = irregV "be" "bad" "bedt" ;
  lin bite_V = irregV "bite" (variants {"bet" ; "beit"}) "bitt" ;
  lin bli_V = irregV "bli" (variants {"ble" ; "blei"}) "blitt" ;
  lin brenne_V = irregV "brenne" (variants {"brant" ; "brente"}) "brent" ;
  lin bringe_V = irregV "bringe" "brakte" "brakt" ;
  lin burde_V = irregV "burde" "burde" "burdet" ;
  lin b�re_V = irregV "b�re" "bar" "b�ret" ;
  lin dra_V = mkV "dra" "drar" "dras" "drog" (variants {"dradd" ; "dratt"}) "dra" ;
  lin drikke_V = irregV "drikke" "drakk" "drukket" ;
  lin drive_V = irregV "drive" (variants {"drev" ; "dreiv"}) "drevet" ;
  lin d�_V = irregV "d�" (variants {"d�dde" ; "d�de"}) "d�dd" ;
  lin eie_V = irregV "eie" (variants {"eide" ; "�tte"}) (variants {"eid" ; "�tt"}) ;
  lin falle_V = irregV "falle" "falt" "falt" ;
  lin finne_V = irregV "finne" "fant" "funnet" ;
  lin fly_V = irregV "fly" (variants {"fl�y" ; "flaug"}) (variants {"fl�yet" ; "flydd"}) ;  lin flyte_V = irregV "flyte" (variants {"fl�te" ; "flaut"}) "flytt" ;
  lin foretrekke_V = irregV "foretrekke" "foretrakk" "foretrukket" ;
  lin forlate_V = irregV "forlate" "forlot" "forlatt" ;
  lin forst�_V = irregV "forst�" "forstod" "forst�tt" ;
  lin fortelle_V = irregV "fortelle" "fortalte" "fortalt" ;
  lin fryse_V = irregV "fryse" "fr�s" "frosset" ;
  lin f�_V = irregV "f�" "fikk" "f�tt" ;
  lin gi_V = irregV "gi" "gav" "gitt" ;
  lin gjelde_V = irregV "gjelde" (variants {"gjaldt" ; "galdt"}) "gjeldt" ;
  lin gj�re_V = irregV "gj�re" "gjorde" "gjort" ;
  lin gni_V = irregV "gni" (variants {"gned" ; "gnei" ; "gnidde"}) "gnidd" ;
  lin g�_V = irregV "g�" "gikk" "g�tt" ;
  lin ha_V = irregV "ha" "hadde" "hatt" ;
  lin hente_V = irregV "hente" "hentet" "hendt" ;
  lin hete_V = irregV "hete" (variants {"het" ; "hette"}) "hett" ;
  lin hjelpe_V = irregV "hjelpe" "hjalp" "hjulpet" ;
  lin holde_V = irregV "holde" "holdt" "holdt" ;
  lin komme_V = irregV "komme" "kom" "kommet" ;
  lin kunne_V = irregV "kunne" "kunne" "kunnet" ;
  lin la_V = irregV "la" "lot" "latt" ;
  lin legge_V = irregV "legge" "la" "lagt" ;
  lin ligge_V = irregV "ligge" "l�" "ligget" ;
  lin l�pe_V = irregV "l�pe" "l�p" (variants {"l�pt" ; "l�pet"}) ;
  lin m�tte_V = irregV "m�tte" "m�tte" "m�ttet" ;
  lin renne_V = irregV "renne" "rant" "rent" ;
  lin se_V = irregV "se" "s�" "sett" ;
  lin selge_V = irregV "selge" "solgte" "solgt" ;
  lin sette_V = irregV "sette" "satte" "satt" ;
  lin si_V = irregV "si" "sa" "sagt" ;
  lin sitte_V = irregV "sitte" "satt" "sittet" ;
  lin skj�re_V = irregV "skj�re" "skar" "sk�ret" ;
  lin skrive_V = irregV "skrive" "skrev" "skrevet" ;
  lin skulle_V = irregV "skulle" "skulle" "skullet" ;
  lin sl�_V = irregV "sl�" "slo" "sl�tt" ;
  lin sl�ss_V = mkV "sl�ss" "sl�ss" "sl�ss" "sloss" "sl�ss" "sl�ss" ;
  lin sove_V = irregV "sove" "sov" "sovet" ;
  lin springe_V = irregV "springe" "sprang" "sprunget" ;
  lin sp�rre_V = irregV "sp�rre" "spurte" "spurt" ;
  lin stikke_V = irregV "stikke" "stakk" "stukket" ;
  lin st�_V = irregV "st�" "stod" "st�tt" ;
  lin suge_V = irregV "suge" (variants {"sugde" ; "saug"}) "sugd" ;
  lin synes_V = irregV "synes" "syntes" (variants {"synes" ; "syns"}) ;
  lin synge_V = irregV "synge" "sang" "sunget" ;
  lin ta_V = irregV "ta" "tok" "tatt" ;
  lin treffe_V = irregV "treffe" "traff" "truffet" ;
  lin trives_V = irregV "trives" "trivdes" (variants {"trives" ; "trivs"}) ;
  lin ville_V = irregV "ville" "ville" "villet" ;
  lin vite_V = mkV "vite" "vet" "vetes" "visste" "visst" "vit" ;
}
