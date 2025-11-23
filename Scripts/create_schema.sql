CREATE DATABASE IF NOT EXISTS TurnierDB;
USE TurnierDB;

-- Tabelle 'sport':
-- Verwaltet die verschiedenen Teamsportarten (z.B. Fußball, Basketball)
-- inklusive Standardteamgröße und Angabe, ob Hallensport oder nicht.
CREATE TABLE IF NOT EXISTS sport
(
    sport_id          INT(11)      NOT NULL AUTO_INCREMENT,
    name              VARCHAR(30)  NOT NULL,
    default_team_size INT DEFAULT NULL,
    is_indoor         BOOLEAN,
    PRIMARY KEY (sport_id),
    UNIQUE KEY uq_sport_name (name)
);

-- Tabelle 'season'
-- Speichert die Saisons (z.B. "SoSe 2025") mit Start- und Enddatum,
-- um Wettbewerbe zeitlich zu strukturieren.
CREATE TABLE IF NOT EXISTS season
(
    season_id  INT(11)     NOT NULL AUTO_INCREMENT,
    name       VARCHAR(30) NOT NULL,
    start_date DATE        NOT NULL,
    end_date   DATE        NOT NULL,
    PRIMARY KEY (season_id),
    CHECK (start_date < end_date)
);

-- Tabelle 'competition'
-- Beschreibt konkrete Wettbewerbe/Ligen einer Sportart in einer bestimmten Saison
-- (z.B. "Hochschulliga Fußball Herren SoSe 2025") mit Level, Modus und Geschlechterkategorie.
CREATE TABLE IF NOT EXISTS competition
(
    competition_id  INT(11)     NOT NULL AUTO_INCREMENT,
    sport_id        INT(11)     NOT NULL,
    season_id       INT(11)     NOT NULL,
    name            VARCHAR(100) NOT NULL,
    level           VARCHAR(30),
    gender_category VARCHAR(30),
    mode            VARCHAR(30),
    PRIMARY KEY (competition_id),
    CONSTRAINT fk_comp_sport
        FOREIGN KEY (sport_id)  REFERENCES sport (sport_id),
    CONSTRAINT fk_comp_season
        FOREIGN KEY (season_id) REFERENCES season (season_id),
    -- Eine Competition soll je Sport/Saison/Name nur einmal existieren
    UNIQUE KEY uq_comp_sport_season_name (sport_id, season_id, name)
);

-- Tabelle 'venue'
-- Enthält alle Spielorte (Hallen/Plätze) der Hochschule inklusive Stadt und Kapazität,
-- an denen Spiele der Competitions ausgetragen werden.
CREATE TABLE IF NOT EXISTS venue
(
    venue_id INT(11)     NOT NULL AUTO_INCREMENT,
    name     VARCHAR(100) NOT NULL,
    city     VARCHAR(50) NOT NULL,
    capacity INT(11),
    PRIMARY KEY (venue_id)
);

-- Tabelle 'team'
-- Speichert alle Teams (unabhängig von einzelnen Competitions) mit Namen, Kurzname
-- und einem zugeordneten Heimspielort (home_venue_id).
CREATE TABLE IF NOT EXISTS team
(
    team_id       INT(11)     NOT NULL AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    short_name    VARCHAR(10),
    home_venue_id INT(11)     NOT NULL,
    PRIMARY KEY (team_id),
    CONSTRAINT fk_team_home_venue
        FOREIGN KEY (home_venue_id) REFERENCES venue(venue_id)
);

-- Tabelle 'player'
-- Verwaltet die Spieler:innen mit Stammdaten (Name, Matrikelnummer, Geburtsdatum, E-Mail),
-- die später Teams und Spielen zugeordnet werden.
CREATE TABLE IF NOT EXISTS player
(
    player_id     INT(11)      NOT NULL AUTO_INCREMENT,
    first_name    VARCHAR(20)  NOT NULL,
    last_name     VARCHAR(30)  NOT NULL,
    student_id    VARCHAR(20)  NOT NULL,
    date_of_birth DATE         NOT NULL,
    email         VARCHAR(50),
    PRIMARY KEY (player_id),
    -- Matrikelnummer soll eindeutig sein
    UNIQUE KEY uq_player_student_id (student_id)
);

-- Tabelle 'team_player'
-- Bildet die M:N-Zuordnung zwischen Teams und Spieler:innen ab.
-- Enthält zusätzlich Kaderzeiträume (from/to_date), Rückennummer und Position
-- und ermöglicht damit eine Kaderhistorie pro Team.
CREATE TABLE IF NOT EXISTS team_player
(
    team_id       INT(11)  NOT NULL,
    player_id     INT(11)  NOT NULL,
    from_date     DATETIME NOT NULL,
    to_date       DATETIME,
    jersey_number INT(3),
    position      VARCHAR(20),
    PRIMARY KEY (team_id, player_id, from_date),
    CONSTRAINT fk_team_player_team
        FOREIGN KEY (team_id)   REFERENCES team (team_id),
    CONSTRAINT fk_team_player_player
        FOREIGN KEY (player_id) REFERENCES player (player_id)
);

-- Tabelle 'game'
-- Speichert alle Spiele einer Competition mit Zuordnung zu Wettbewerb, Spielort,
-- Heim- und Auswärtsteam, geplantem Zeitpunkt, Ergebnis und Spielstatus.
CREATE TABLE IF NOT EXISTS game
(
    game_id            INT(11)  NOT NULL AUTO_INCREMENT,
    competition_id     INT(11)  NOT NULL,
    venue_id           INT(11)  NOT NULL,
    gameday_number     INT(11),
    stage              VARCHAR(15),
    scheduled_datetime DATETIME NOT NULL,
    away_team_id       INT(11)  NOT NULL,
    home_team_id       INT(11)  NOT NULL,
    home_score         INT(11) DEFAULT NULL,
    away_score         INT(11) DEFAULT NULL,
    status             VARCHAR(15),
    PRIMARY KEY (game_id),
    CONSTRAINT fk_game_competition
        FOREIGN KEY (competition_id) REFERENCES competition (competition_id),
    CONSTRAINT fk_game_venue
        FOREIGN KEY (venue_id)       REFERENCES venue (venue_id),
    CONSTRAINT fk_game_away_team
        FOREIGN KEY (away_team_id)   REFERENCES team (team_id),
    CONSTRAINT fk_game_home_team
        FOREIGN KEY (home_team_id)   REFERENCES team (team_id),
    CHECK (home_team_id <> away_team_id)
);


-- Tabelle 'comp_team'
-- Bildet die M:N-Zuordnung zwischen Competitions und Teams ab,
-- um festzulegen, welche Teams in welchen Wettbewerben antreten.
CREATE TABLE IF NOT EXISTS comp_team
(
    competition_id INT(11) NOT NULL,
    team_id        INT(11) NOT NULL,
    registration_date DATE NOT NULL,
    group_name       VARCHAR(30),
    PRIMARY KEY (competition_id, team_id),
    CONSTRAINT fk_comp_team_competition
        FOREIGN KEY (competition_id) REFERENCES competition (competition_id),
    CONSTRAINT fk_comp_team_team
        FOREIGN KEY (team_id)        REFERENCES team (team_id)
);

-- Tabelle 'game_event'
-- Protokolliert Ereignisse während eines Spiels (z.B. Tore, Karten)
CREATE TABLE IF NOT EXISTS game_event
(
    event_id     INT(11)  NOT NULL AUTO_INCREMENT,
    game_id      INT(11)  NOT NULL,
    event_minute   INT(11)  NOT NULL,
    event_type   VARCHAR(30) NOT NULL,
    player_id    INT(11) NOT NULL,
    team_id      INT(11) NOT NULL,
    description  VARCHAR(100),
    PRIMARY KEY (event_id),
    CONSTRAINT fk_game_event_game
        FOREIGN KEY (game_id)   REFERENCES game (game_id),
    CONSTRAINT fk_game_event_player
        FOREIGN KEY (player_id) REFERENCES player (player_id),
    CONSTRAINT fk_game_event_team
        FOREIGN KEY (team_id)   REFERENCES team (team_id)
);