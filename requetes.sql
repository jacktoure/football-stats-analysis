-- =============================================
-- PROJET : Analyse Football Européen (2008-2016)
-- SOURCE : European Soccer Database (Kaggle)
-- OUTIL  : DB Browser for SQLite
-- =============================================

-- 1. Exploration des ligues disponibles
SELECT * FROM League;

-- 2. Top 10 des équipes avec le plus de victoires à domicile
SELECT 
    t.team_long_name AS Equipe,
    COUNT(*) AS Victoires_domicile
FROM Match m
JOIN Team t ON m.home_team_api_id = t.team_api_id
WHERE m.home_team_goal > m.away_team_goal
GROUP BY t.team_long_name
ORDER BY Victoires_domicile DESC
LIMIT 10;

-- 3. Top 10 des matchs avec le plus de buts
SELECT 
    t1.team_long_name AS Equipe_domicile,
    t2.team_long_name AS Equipe_exterieur,
    m.home_team_goal AS Buts_domicile,
    m.away_team_goal AS Buts_exterieur,
    (m.home_team_goal + m.away_team_goal) AS Total_buts,
    m.season AS Saison
FROM Match m
JOIN Team t1 ON m.home_team_api_id = t1.team_api_id
JOIN Team t2 ON m.away_team_api_id = t2.team_api_id
ORDER BY Total_buts DESC
LIMIT 10;

-- 4. Évolution des buts par match en Ligue 1
SELECT 
    m.season AS Saison,
    ROUND(AVG(m.home_team_goal + m.away_team_goal), 2) AS Moyenne_buts_par_match,
    COUNT(*) AS Nombre_matchs
FROM Match m
WHERE m.league_id = 4769
GROUP BY m.season
ORDER BY m.season ASC;

-- 5. Top 10 des équipes les plus fortes à l'extérieur
SELECT 
    t.team_long_name AS Equipe,
    COUNT(*) AS Victoires_exterieur
FROM Match m
JOIN Team t ON m.away_team_api_id = t.team_api_id
WHERE m.away_team_goal > m.home_team_goal
GROUP BY t.team_long_name
ORDER BY Victoires_exterieur DESC
LIMIT 10;
