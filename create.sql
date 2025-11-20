--
-- Tabellenstruktur für Tabelle 'Sport'
--

CREATE TABLE IF NOT EXISTS sport
(
    sport_id          int(11)     NOT NULL auto_increment,
    name              varchar(30) NOT NULL,
    default_team_size int default NULL,
    is_indoor         boolean,
    PRIMARY KEY (sport_id)
);

--
-- Tabellenstruktur für Tabelle 'Season'
--

CREATE TABLE IF NOT EXISTS season
(
    season_id  int(11)     NOT NULL auto_increment,
    name       varchar(30) NOT NULL,
    start_date DATE        NOT NULL,
    end_date   DATE        NOT NULL,
    PRIMARY KEY (season_id)
);

--
-- Tabellenstruktur für Tabelle 'Competition'
--
CREATE TABLE IF NOT EXISTS competition
(
    competition_id  int(11)     NOT NULL auto_increment,
    sport_id        int(11)     NOT NULL,
    season_id       int(11)     NOT NULL,
    name            varchar(30) NOT NULL,
    level           varchar(30),
    gender_category varchar(30),
    mode            varchar(30),
    PRIMARY KEY (competition_id),
    FOREIGN KEY (sport_id) references sport (sport_id),
    FOREIGN KEY (season_id) references season (season_id)
);

--
-- Tabellenstruktur für Tabelle 'Venue'
--
CREATE TABLE IF NOT EXISTS venue
(
    venue_id int(11)     NOT NULL auto_increment,
    name     varchar(20) NOT NULL,
    city     varchar(20) NOT NULL,
    capacity int(11),
    PRIMARY KEY (venue_id)
);

--
-- Tabellenstruktur für Tabelle 'Team'
--
CREATE TABLE IF NOT EXISTS team
(
    team_id       int(11)     NOT NULL auto_increment,
    name          varchar(30) NOT NULL,
    short_name    varchar(10),
    home_venue_id int(11)     NOT NULL,
    PRIMARY KEY (team_id),
    FOREIGN KEY (home_venue_id) references venue(venue_id)
);

--
-- Tabellenstruktur für Tabelle 'Player'
--
CREATE TABLE IF NOT EXISTS player
(
    player_id     int(11)     NOT NULL auto_increment,
    first_name    varchar(20) NOT NULL,
    last_name     varchar(30) NOT NULL,
    student_id    int(11)     NOT NULL,
    date_of_birth DATETIME    NOT NULL,
    email         varchar(50),
    PRIMARY KEY (player_id)
);

--
-- Tabellenstruktur für Tabelle 'Team Player Zuordnung'
--
CREATE TABLE IF NOT EXISTS team_player
(
    team_id       int(11) NOT NULL,
    player_id     int(11) NOT NULL,
    from_date     DATETIME,
    to_date       DATETIME,
    jersey_number int(3),
    position      varchar(20),
    FOREIGN KEY (team_id) references team (team_id),
    FOREIGN KEY (player_id) references player (player_id)
);

--
-- Tabellenstruktur für Tabelle 'Game'
--
CREATE TABLE IF NOT EXISTS game
(
    game_id            int(11)  NOT NULL auto_increment,
    competition_id     int(11)  NOT NULL,
    venue_id           int(11)  NOT NULL,
    gameday_number     int(11),
    stage              varchar(15),
    scheduled_datetime DATETIME NOT NULL,
    away_team_id       int(11)  NOT NULL,
    home_team_id       int(11)  NOT NULL,
    home_score         int(11) default NULL,
    away_score         int(11) default NULL,
    status             varchar(15),
    PRIMARY KEY (game_id),
    FOREIGN KEY (competition_id)references competition (competition_id),
    FOREIGN KEY (venue_id) references venue (venue_id),
    FOREIGN KEY (away_team_id) references team (team_id),
    FOREIGN KEY (home_team_id) references team (team_id)
);

--
-- Tabellenstruktur für Tabelle 'game_player_stat'
--
CREATE TABLE IF NOT EXISTS game_player_stat
(
    game_id        int(11) NOT NULL,
    player_id      int(11) NOT NULL,
    team_id        int(11) NOT NULL,
    points         int(5),
    goals          int(5),
    minutes_played int(10),
    fouls          int(5),
    FOREIGN KEY (game_id) references game (game_id),
    FOREIGN KEY (player_id) references player (player_id),
    FOREIGN KEY (team_id) references team (team_id)
);

--
-- Tabellenstruktur für Tabelle 'Referee'
--
CREATE TABLE IF NOT EXISTS referee
(
    referee_id         int(11)     NOT NULL auto_increment,
    first_name         varchar(20) NOT NULL,
    last_name          varchar(30) NOT NULL,
    preferred_sport_id int(11)     NOT NULL,
    PRIMARY KEY (referee_id),
    FOREIGN KEY (preferred_sport_id) references sport (sport_id)
);

--
-- Tabellenstruktur für Tabelle 'game_referee Zuordnung'
--
CREATE TABLE IF NOT EXISTS game_referee
(
    game_id    int(11) NOT NULL,
    referee_id int(11) NOT NULL,
    role       varchar(25),
    FOREIGN KEY (game_id) references game (game_id),
    FOREIGN KEY (referee_id) references referee (referee_id)
);
