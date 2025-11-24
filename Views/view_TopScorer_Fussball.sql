use TurnierDB;

CREATE OR REPLACE VIEW vw_top_scorer_2025_fussball AS
WITH comp AS (
    SELECT competition_id
    FROM competition
    WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'
    LIMIT 1
),

     goal_events AS (
         SELECT
             ge.player_id,
             COUNT(*) AS goals
         FROM game_event ge
                  JOIN game g ON g.game_id = ge.game_id
                  JOIN comp c ON c.competition_id = g.competition_id
         WHERE ge.event_type = 'Tor'
         GROUP BY ge.player_id
     ),

-- alle Spieler, die im Kader eines Turnierteams stehen
     tournament_players AS (
         SELECT DISTINCT
             p.player_id,
             p.first_name,
             p.last_name,
             p.student_id,
             t.team_id,
             t.name       AS team_name,
             t.short_name AS team_short
         FROM comp_team ct
                  JOIN comp c
                       ON ct.competition_id = c.competition_id
                  JOIN team t
                       ON t.team_id = ct.team_id
                  JOIN team_player tp
                       ON tp.team_id = t.team_id
                           AND tp.to_date IS NULL          -- aktueller Kader
                  JOIN player p
                       ON p.player_id = tp.player_id
     )

SELECT
    tp.player_id,
    tp.first_name,
    tp.last_name,
    tp.student_id,
    tp.team_id,
    tp.team_name,
    tp.team_short,
    COALESCE(ge.goals, 0) AS goals
FROM tournament_players tp
         LEFT JOIN goal_events ge
                   ON ge.player_id = tp.player_id
ORDER BY
    goals DESC,
    tp.last_name ASC,
    tp.first_name ASC;
