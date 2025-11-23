use TurnierDB;

CREATE OR REPLACE VIEW vw_top_scorer_2025_fussball AS
WITH goal_events AS (
    SELECT
        ge.player_id,
        COUNT(*) AS goals
    FROM game_event ge
             JOIN game g ON g.game_id = ge.game_id
             JOIN competition c ON c.competition_id = g.competition_id
    WHERE ge.event_type = 'Tor'
      AND c.name = 'Hochschulcup Fußball Herren SoSe 2025'
    GROUP BY ge.player_id
)

SELECT
    p.player_id,
    p.first_name,
    p.last_name,
    p.student_id,
    t.team_id,
    t.name AS team_name,
    t.short_name AS team_short,
    COALESCE(g.goals, 0) AS goals
FROM player p
         LEFT JOIN team_player tp ON tp.player_id = p.player_id
         LEFT JOIN team t        ON t.team_id = tp.team_id
         LEFT JOIN goal_events g ON g.player_id = p.player_id
WHERE tp.to_date IS NULL   -- aktueller Kader
ORDER BY goals DESC, last_name ASC, first_name ASC;
;