-- Requête 1 : Nombre d'enfants par sexe en fonction du mois 

SELECT D.mois, E.sexe, COUNT(E.sexe)
	FROM TableFaitsNaissance N, TableEnfant E, TableDate D,
		WHERE (E.idEnfant = N.idEnfant) 
			GROUP BY (D.mois, E.sexe) WITH ROLLUP;
			
-- Requête 2 : Rang des départements en fonction du nombre d'enfants par sexe 
			
SELECT P.IdDepartement, E.sexe, COUNT(E.sexe), DENSE_RANK() over (ORDER BY COUNT(P.IdDepartement) desc)
	FROM TableFaitsNaissance N, TableEnfant E, TableDepartement P, 
		WHERE (E.idEnfant = N.idEnfant)
			GROUP ();
			
-- Requête 3 : 			
			
SELECT *, 
       COUNT(*) OVER(PARTITION BY condition) AS NB_NAISSANCE
FROM   TableFaitsNaissance 
ORDER  condition
			
				
			
-- Requête 4 : Comparer les âges des deux parents


-- Requête 5 : Situation professionnelle -> condition, reconnaissance enfants 


-- Requête 6 : Comparaison des reconnaissances de l'enfant


-- Requête 7 : 


-- Requête 8 : 


-- Requête 9 :


-- Requête 10 :Comparaison âge/jumeaux 


-- Requête 11 :


-- Requête 12 :
