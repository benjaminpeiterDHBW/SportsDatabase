use TurnierDB;

CREATE OR REPLACE VIEW vw_hochschulcup_basketball_2025_abschluss AS
WITH
    comp AS (
        SELECT competition_id
        FROM competition
        WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'
        LIMIT 1
    ),

-- Spiele aus Sicht jedes Teams (nur fertige Spiele)
    game_results AS (
        -- Heimteam-Sicht
        SELECT
            g.competition_id,
            g.game_id,
            g.home_team_id AS team_id,
            g.home_score    AS goals_for,
            g.away_score    AS goals_against,
            CASE
                WHEN g.home_score > g.away_score THEN 1
                WHEN g.home_score < g.away_score THEN 0
                ELSE 0
                END AS wins
        FROM game g
                 JOIN comp c ON g.competition_id = c.competition_id
        WHERE g.status = 'Finished'

        UNION ALL

        -- Auswärtsteam-Sicht
        SELECT
            g.competition_id,
            g.game_id,
            g.away_team_id AS team_id,
            g.away_score    AS goals_for,
            g.home_score    AS goals_against,
            CASE
                WHEN g.away_score > g.home_score THEN 1
                WHEN g.away_score < g.home_score THEN 0
                ELSE 0
                END AS wins
        FROM game g
                 JOIN comp c ON g.competition_id = c.competition_id
        WHERE g.status = 'Finished'
    ),

    team_stats AS (
        SELECT
            t.team_id,
            t.name,
            t.short_name,
            COUNT(gr.game_id)                       AS games_played,
            COALESCE(SUM(gr.wins), 0)              AS wins,
            COALESCE(SUM(gr.goals_for), 0)         AS goals_for,
            COALESCE(SUM(gr.goals_against), 0)     AS goals_against
        FROM comp_team ct
                 JOIN comp c
                      ON ct.competition_id = c.competition_id
                 JOIN team t
                      ON t.team_id = ct.team_id
                 LEFT JOIN game_results gr
                           ON gr.competition_id = c.competition_id
                               AND gr.team_id = t.team_id
        GROUP BY t.team_id, t.name, t.short_name
    ),

    final_table AS (
        SELECT
            ts.*,
            (ts.goals_for - ts.goals_against) AS goal_diff,
            ROW_NUMBER() OVER (
                ORDER BY
                    ts.wins        DESC,
                    ts.goals_for   DESC,
                    ts.goals_against ASC,
                    ts.team_id     ASC
                ) AS place
        FROM team_stats ts
    )

SELECT
    place,
    name,
    short_name,
    games_played,
    wins,
    goals_for,
    goals_against,
    goal_diff
FROM final_table
ORDER BY place;
;