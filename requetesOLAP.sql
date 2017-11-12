-- Requête 1 : Nombre d'enfants par sexe en fonction du mois 

SELECT D.mois, E.sexe, COUNT(E.sexe)
	FROM TableFaitsNaissance N, TableEnfant E, TableDate D,
		WHERE (E.idEnfant = N.idEnfant) 
			GROUP BY ROLLUP(D.mois, E.sexe);
			
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
			
			
-- Requête 4 : L’influence de la situation professionnelle sur les conditions d’accouchement


-- Requête 5 : 


-- Requête 6 : 


-- Requête 7 : 


-- Requête 8 : 


-- Requête 9 :


-- Requête 10 :


-- Requête 11 :


-- Requête 12 :
