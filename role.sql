-- Rollen anlegen
CREATE ROLE r_vereinsmanager;
CREATE ROLE r_turnierveranstalter;
CREATE ROLE r_spielberichtserstatter;
CREATE ROLE r_viewer;
CREATE ROLE r_datenpfleger;

-- Nutzer anlegen
CREATE USER 'systemadministrator'@'%' IDENTIFIED BY 'secure_password';
CREATE USER 'tim'@'%' IDENTIFIED BY 'tim_password';

-- ---------------------------------------------------
-- Vereinsmanager
-- Darf Spieler und Kader verwalten → SELECT, INSERT, UPDATE auf player / team_player
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.player       TO r_vereinsmanager;
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.team_player  TO r_vereinsmanager;
GRANT SELECT
    ON sportsdb.game         TO r_vereinsmanager;
GRANT SELECT
    ON sportsdb.competition  TO r_vereinsmanager;

-- Turnierveranstalter
-- Darf Wettbewerbe, Spiele und Competition-Team-Zuordnungen verwalten
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.competition TO r_turnierveranstalter;
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.game        TO r_turnierveranstalter;
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.comp_team   TO r_turnierveranstalter;
GRANT SELECT
    ON sportsdb.team        TO r_turnierveranstalter;
GRANT SELECT
    ON sportsdb.venue       TO r_turnierveranstalter;

-- Spielberichtserstatter
-- Darf Ereignisse schreiben und Spielstände aktualisieren.
-- SELECT ist notwendig, um z. B. game_id oder player_id korrekt zu prüfen.
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.game_event TO r_spielberichtserstatter;
GRANT SELECT
    ON sportsdb.player     TO r_spielberichtserstatter;
GRANT SELECT
    ON sportsdb.game       TO r_spielberichtserstatter;

-- Einschränkte UPDATE-Rechte nur auf Scorefelder
GRANT UPDATE(home_score, away_score)
    ON sportsdb.game TO r_spielberichtserstatter;

-- Viewer
-- Nur lesender Zugriff auf die gesamte Datenbank
GRANT SELECT
    ON sportsdb.* TO r_viewer;

-- Datenpfleger
-- Darf Stammdaten pflegen: Sportarten, Saisons, Spielorte, Teams
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.sport TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE
    ON sportsdb.season TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE, DELETE
    ON sportsdb.venue TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE, DELETE
    ON sportsdb.team TO r_datenpfleger;

-- Systemadministrator
-- Vollzugriff auf die gesamte Datenbank inkl. GRANT OPTION
GRANT ALL PRIVILEGES ON sportsdb.*
    TO 'systemadministrator'@'%' WITH GRANT OPTION;
-- ---------------------------------------------------

-- Rechte vergeben
GRANT r_vereinsmanager TO 'tim'@'%';


FLUSH PRIVILEGES;