use TurnierDB;

CREATE OR REPLACE VIEW vw_hochschulcup_2025_home_win_rateFussball AS
WITH
    comp AS (
        SELECT competition_id
        FROM competition
        WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'
        LIMIT 1
    ),

    home_games AS (
        SELECT
            g.home_team_id AS team_id,
            COUNT(*) AS home_games,
            SUM(CASE WHEN g.home_score > g.away_score THEN 1 ELSE 0 END) AS home_wins,
            SUM(CASE WHEN g.home_score = g.away_score THEN 1 ELSE 0 END) AS home_draws,
            SUM(CASE WHEN g.home_score < g.away_score THEN 1 ELSE 0 END) AS home_losses
        FROM game g
                 JOIN comp c ON g.competition_id = c.competition_id
        WHERE g.status = 'Finished'
        GROUP BY g.home_team_id
    )

SELECT
    t.name,
    t.short_name,
    hg.home_games,
    hg.home_wins,
    hg.home_draws,
    hg.home_losses,
    ROUND(hg.home_wins / hg.home_games * 100, 2) AS home_win_percentage
FROM home_games hg
         JOIN team t ON t.team_id = hg.team_id
ORDER BY
    home_win_percentage DESC,
    hg.home_games DESC,
    t.short_name;
