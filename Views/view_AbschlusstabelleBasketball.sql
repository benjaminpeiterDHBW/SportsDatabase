CREATE OR REPLACE VIEW vw_hochschulcup_basketball_2025_abschluss AS
WITH
-- Wettbewerb bestimmen
comp AS (
    SELECT competition_id
    FROM competition
    WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'
    LIMIT 1
),

-- Punkte je Team und Spiel aus den Events berechnen
game_points AS (
    SELECT
        g.game_id,
        ge.team_id,
        SUM(
                CASE
                    WHEN ge.event_type = '3-Punkte-Wurf' THEN 3
                    WHEN ge.event_type = '2-Punkte-Wurf' THEN 2
                    WHEN ge.event_type = 'Freiwurf'      THEN 1
                    ELSE 0
                    END
        ) AS points_for
    FROM game_event ge
             JOIN game g
                  ON ge.game_id = g.game_id
             JOIN comp c
                  ON g.competition_id = c.competition_id
    GROUP BY g.game_id, ge.team_id
),

-- Ergebnisse aus Sicht jedes Teams (nur fertige Spiele)
game_results AS (
    -- Heimteam
    SELECT
        g.competition_id,
        g.game_id,
        g.home_team_id AS team_id,
        COALESCE(h.points_for, 0) AS points_for,
        COALESCE(a.points_for, 0) AS points_against,
        CASE
            WHEN COALESCE(h.points_for, 0) > COALESCE(a.points_for, 0) THEN 1
            WHEN COALESCE(h.points_for, 0) < COALESCE(a.points_for, 0) THEN 0
            ELSE 0
            END AS wins
    FROM game g
             JOIN comp c ON g.competition_id = c.competition_id
             LEFT JOIN game_points h
                       ON h.game_id = g.game_id
                           AND h.team_id = g.home_team_id
             LEFT JOIN game_points a
                       ON a.game_id = g.game_id
                           AND a.team_id = g.away_team_id
    WHERE g.status = 'Finished'

    UNION ALL

    -- Auswärtsteam
    SELECT
        g.competition_id,
        g.game_id,
        g.away_team_id AS team_id,
        COALESCE(a.points_for, 0) AS points_for,
        COALESCE(h.points_for, 0) AS points_against,
        CASE
            WHEN COALESCE(a.points_for, 0) > COALESCE(h.points_for, 0) THEN 1
            WHEN COALESCE(a.points_for, 0) < COALESCE(h.points_for, 0) THEN 0
            ELSE 0
            END AS wins
    FROM game g
             JOIN comp c ON g.competition_id = c.competition_id
             LEFT JOIN game_points h
                       ON h.game_id = g.game_id
                           AND h.team_id = g.home_team_id
             LEFT JOIN game_points a
                       ON a.game_id = g.game_id
                           AND a.team_id = g.away_team_id
    WHERE g.status = 'Finished'
),

-- Aggregation pro Team
team_stats AS (
    SELECT
        t.team_id,
        t.name,
        t.short_name,
        COUNT(gr.game_id)                   AS games_played,
        COALESCE(SUM(gr.wins), 0)          AS wins,
        COALESCE(SUM(gr.points_for), 0)    AS points_for,
        COALESCE(SUM(gr.points_against),0) AS points_against
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
        (ts.points_for - ts.points_against) AS point_diff,
        ROW_NUMBER() OVER (
            ORDER BY
                ts.wins        DESC,   -- zuerst nach Siegen
                ts.points_for  DESC,   -- dann nach erzielten Punkten
                ts.points_against ASC, -- dann nach kassierten Punkten
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
    points_for,
    points_against,
    point_diff
FROM final_table
ORDER BY place;
