use TurnierDB;

CREATE OR REPLACE VIEW vw_top_scorer_2025_basketball AS
WITH
-- Wettbewerb einschränken
comp AS (
    SELECT competition_id
    FROM competition
    WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'
    LIMIT 1
),

-- Punkte je Spieler in diesem Wettbewerb
points_per_player AS (
    SELECT
        p.player_id,
        p.first_name,
        p.last_name,
        t.team_id,
        t.name       AS team_name,
        t.short_name AS team_short_name,
        -- einzelne Zählwerte
        SUM(CASE WHEN ge.event_type = '3-Punkte-Wurf' THEN 1 ELSE 0 END) AS three_pt_made,
        SUM(CASE WHEN ge.event_type = '2-Punkte-Wurf' THEN 1 ELSE 0 END) AS two_pt_made,
        SUM(CASE WHEN ge.event_type = 'Freiwurf'       THEN 1 ELSE 0 END) AS free_throws_made,
        -- Gesamtpunkte
        SUM(
                CASE
                    WHEN ge.event_type = '3-Punkte-Wurf' THEN 3
                    WHEN ge.event_type = '2-Punkte-Wurf' THEN 2
                    WHEN ge.event_type = 'Freiwurf'       THEN 1
                    ELSE 0
                    END
        ) AS total_points
    FROM game_event ge
             JOIN game g
                  ON ge.game_id = g.game_id
             JOIN comp c
                  ON g.competition_id = c.competition_id
             JOIN player p
                  ON ge.player_id = p.player_id
             LEFT JOIN team t
                       ON ge.team_id = t.team_id
    WHERE ge.event_type IN ('3-Punkte-Wurf', '2-Punkte-Wurf', 'Freiwurf')
    GROUP BY
        p.player_id,
        p.first_name,
        p.last_name,
        t.team_id,
        t.name,
        t.short_name
),

ranked AS (
    SELECT
        pp.*,
        ROW_NUMBER() OVER (
            ORDER BY
                pp.total_points DESC,
                pp.three_pt_made DESC,
                pp.two_pt_made   DESC,
                pp.free_throws_made DESC,
                pp.last_name ASC,
                pp.first_name ASC
            ) AS rank_pos
    FROM points_per_player pp
)

SELECT
    rank_pos      AS place,
    first_name,
    last_name,
    team_name,
    team_short_name,
    total_points,
    three_pt_made,
    two_pt_made,
    free_throws_made
FROM ranked
ORDER BY place;
;