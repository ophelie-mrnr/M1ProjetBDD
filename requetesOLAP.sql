-- Requête 1 : Nombre d'enfants par sexe en fonction du mois.

SELECT D.Mois, E.Sexe_de_l_enfant, COUNT(E.idEnfant) 
FROM faitNaissanceTest N, dimEnfant E, dimDate D 
WHERE N.idEnfant = E.idEnfant AND D.idDate = N.idDate
		GROUP BY D.Mois, E.Sexe_de_l_enfant WITH ROLLUP ;

--Cette requête renvoie le nombre d’enfants nés tel mois en fonction de leur sexe. Cette requête peut être intéressante pour définir les mois les plus propices aux naissances ou à l’accouplement. Les compagnies (de publicité par exemple) pourront adapteur leur stratégie en fonction de ces mois ainsi que du sexe de l’enfant. 

-- Requête 2 : Nombre d’enfants par sexe en fonction du département 

SELECT P.idDepartement, E.Sexe_de_l_enfant, COUNT(E.idEnfant) 
FROM faitNaissanceTest N, dimEnfant E, dimDate D, dimDepartement P
WHERE N.idEnfant = E.idEnfant AND N.idDate = D.idDate AND P.idDepartement = N.idDepartement
		GROUP BY P.idDepartement, E.Sexe_de_l_enfant ;

-- Requête 2-bis : Rang des départements en fonction du nombre d'enfants                  	        	
             --Si on considère que count_enfant  est le nombre d’enfants par département trouvé par la requête suivante : 

SELECT P.idDepartement, COUNT(E.idEnfant) 
FROM faitNaissanceTest N, dimEnfant E, dimDate D, dimDepartement P
WHERE N.idEnfant = E.idEnfant AND N.idDate = D.idDate AND P.idDepartement = N.idDepartement		
GROUP BY P.idDepartement;

	--On peut faire un rang des départements qui ont le plus d’enfants. 

SELECT P.idDepartement, count_enfant,
DENSE_RANK() OVER (ORDER BY count_enfant DESC)
FROM faitNaissanceTest N, dimEnfant E, dimDate D, dimDepartement P
GROUP BY idDepartement;


-- Requête 3 : Grouping des naissances par mois et par nombre d’enfants issus de l’accouchement 

SELECT D.Mois, N.nbEnfant, COUNT(N.nbEnfant) as count_enfant
FROM dimEnfant E, faitNaissance N, dimDate D
WHERE E.idEnfant = N.idEnfant AND N.idDate = D.idDate 
GROUP BY D.Mois, N.nbEnfant WITH CUBE
                               	                    	
-- Requête 4 : L’influence de la situation professionnelle sur les conditions d’accouchement
 
SELECT D.Mois, E.Sexe_de_l_enfant, COUNT(E.idEnfant) 
FROM faitNaissanceTest N, dimEnfant E, dimDate D 
WHERE N.idEnfant = E.idEnfant AND D.idDate = N.idDate
		GROUP BY D.Mois, E.Sexe_de_l_enfant WITH ROLLUP ;


-- Requête 5 : Comparaison des reconnaissances de l'enfant
 
 
-- Requête 6 : L’influence de la situation professionnelle sur le temps de reconnaissance de l’enfant

SELECT M.Situation_professionnelle_de_la_mere, P.Situation_professionnelle_du_pere, N.conditionAccouchement, COUNT(E.idEnfant), GROUPING_ID(M.Situation_professionnelle_de_la_mere, M.Situation_professionnelle_de_la_mere, N.conditionAccouchement) as grp 	 	 
FROM faitNaissanceTest N, dimEnfant E, dimDate D, dimMere M, dimPere P
WHERE N.idEnfant = E.idEnfant AND M.idMere = N.idMere AND N.idDate = D.idDate AND P.idPere = N.idPere
	GROUP BY M.Situation_professionnelle_de_la_mere, P.Situation_professionnelle_du_pere, N.conditionAccouchement WITH ROLLUP;


-- Requête 7 : Comparer les âges des deux parents

SELECT idEnfant, ABS(Pr.Age_exact_du_pere_a_la_naissance_de_l_enfant-M.Age_exact_de_la_mere_a_la_naissance_de_l_enfant) AS diff 
FROM dimPere Pr, dimMere M, faitNaissanceTest N 
WHERE Pr.idPere = N.idPere AND M.idMere = N.idPere;

--Requête 7-bis : Grouping des différences des âges des parents ainsi que le nombre de personnes associées 

SELECT ABS(Pr.Age_exact_du_pere_a_la_naissance_de_l_enfant-M.Age_exact_de_la_mere_a_la_naissance_de_l_enfant) AS differenceAge, count(ABS(Pr.Age_exact_du_pere_a_la_naissance_de_l_enfant-M.Age_exact_de_la_mere_a_la_naissance_de_l_enfant)) AS countDifferenceAge
FROM dimPere Pr, dimMere M, faitNaissanceTest N 
WHERE Pr.idPere = N.idPere AND M.idMere = N.idPere
GROUP BY differenceAge
ORDER BY countDifferenceAge desc;

 
-- Requête 8 : recherche des parents (mère et père) qui sont nés en France métropolitaine : Indicateur du lieu de naissance=1 :
 
 
-- Requête 9 : les naissances où au moins un des parents est retraité ou inactif
 
SELECT idMere, idPere
FROM dimmere, dimpere
WHERE dimmere.Situation_professionnelle_de_la_mere = "retraitée ou inactive" AND dimpere.Situation_professionnelle_du_pere = "retraité ou inactif" 
GROUP BY Age_de_la_mere_dans_l_annee_de_naissance_de_l_enfant, Age_du_pere_dans_l_annee_de_naissance_de_l_enfant;


 
-- Requête 10 : les 10 premiers enfants nés au mois de janvier 
 
SELECT idEnfant, idDate
FROM faitNaissance
WHERE SUBSTR (idDate, 3, 2) = “01”
LIMIT 10;
 
-- Requête 11 : TOP 5 durée depuis le dernier événement 

SELECT dureeDernierEvenement,COUNT(N.dureeDernierEvenement) AS count_duree
	FROM faitNaissanceTest N, dimEnfant E, dimDate D, dimDepartement P
	WHERE N.idEnfant = E.idEnfant AND N.idDate = D.idDate AND P.idDepartement = N.idDepartement		
	GROUP BY N.dureeDernierEvenement ORDER BY count_duree DESC LIMIT 5;

-- Requête 12 : Durée entre l’année de mariage et la naissance

SELECT CAST(SUBSTR(N.idDate,5,4) AS UNSIGNED) - CAST(C.Annee_de_mariage_des_parents AS UNSIGNED) as difference_marriage_naissance, count(CAST(SUBSTR(N.idDate,5,4) AS UNSIGNED) - CAST(C.Annee_de_mariage_des_parents AS UNSIGNED)) as count_diff 
FROM dimDate D, faitNaissanceTest N, dimCouple C, dimEnfant E 
WHERE N.idEnfant = E.idEnfant AND N.idDate = D.idDate AND N.idCouple = C.idCouple AND C.Annee_de_mariage_des_parents NOT LIKE "0000" 
GROUP BY difference_marriage_naissance;