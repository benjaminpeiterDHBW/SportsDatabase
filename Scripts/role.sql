-- Rollen anlegen
CREATE OR REPLACE ROLE r_vereinsmanager;
CREATE OR REPLACE ROLE r_turnierveranstalter;
CREATE OR REPLACE ROLE r_spielberichtserstatter;
CREATE OR REPLACE ROLE r_viewer;
CREATE OR REPLACE ROLE r_datenpfleger;

-- ---------------------------------------------------
-- Vereinsmanager
-- Darf Spieler und Kader verwalten → SELECT, INSERT, UPDATE auf player / team_player
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.player       TO r_vereinsmanager;
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.team_player  TO r_vereinsmanager;
GRANT SELECT
    ON turnierdb.game         TO r_vereinsmanager;
GRANT SELECT
    ON turnierdb.competition  TO r_vereinsmanager;

-- Turnierveranstalter
-- Darf Wettbewerbe, Spiele und Competition-Team-Zuordnungen verwalten
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.competition TO r_turnierveranstalter;
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.game        TO r_turnierveranstalter;
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.comp_team   TO r_turnierveranstalter;
GRANT SELECT
    ON turnierdb.team        TO r_turnierveranstalter;
GRANT SELECT
    ON turnierdb.venue       TO r_turnierveranstalter;

-- Spielberichtserstatter
-- Darf Ereignisse schreiben und Spielstände aktualisieren.
-- SELECT ist notwendig, um z. B. game_id oder player_id korrekt zu prüfen.
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.game_event TO r_spielberichtserstatter;
GRANT SELECT
    ON turnierdb.player     TO r_spielberichtserstatter;
GRANT SELECT
    ON turnierdb.game       TO r_spielberichtserstatter;

-- Einschränkte UPDATE-Rechte nur auf Scorefelder
GRANT UPDATE(home_score, away_score)
    ON turnierdb.game TO r_spielberichtserstatter;

-- Viewer
-- Nur lesender Zugriff auf die gesamte Datenbank
GRANT SELECT
    ON turnierdb.* TO r_viewer;

-- Datenpfleger
-- Darf Stammdaten pflegen: Sportarten, Saisons, Spielorte, Teams
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.sport TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE
    ON turnierdb.season TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE, DELETE
    ON turnierdb.venue TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE, DELETE
    ON turnierdb.team TO r_datenpfleger;

-- Systemadministrator
-- Vollzugriff auf die gesamte Datenbank inkl. GRANT OPTION
GRANT ALL PRIVILEGES ON turnierdb.*
    TO 'systemadministrator'@'%' WITH GRANT OPTION;
-- ---------------------------------------------------

-- Nutzer anlegen
CREATE OR REPLACE USER 'systemadministrator'@'%' IDENTIFIED BY 'secure_password';
CREATE OR REPLACE USER 'tim'@'%' IDENTIFIED BY 'tim_password';

-- Rechte vergeben
GRANT r_vereinsmanager TO 'tim'@'%';
SET DEFAULT ROLE r_vereinsmanager FOR 'tim'@'%';


FLUSH PRIVILEGES;