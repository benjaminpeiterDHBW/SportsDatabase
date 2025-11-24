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
    ON TurnierDB.player       TO r_vereinsmanager;
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.team_player  TO r_vereinsmanager;
GRANT SELECT
    ON TurnierDB.game         TO r_vereinsmanager;
GRANT SELECT
    ON TurnierDB.competition  TO r_vereinsmanager;

-- Turnierveranstalter
-- Darf Wettbewerbe, Spiele und Competition-Team-Zuordnungen verwalten
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.competition TO r_turnierveranstalter;
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.game        TO r_turnierveranstalter;
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.comp_team   TO r_turnierveranstalter;
GRANT SELECT
    ON TurnierDB.team        TO r_turnierveranstalter;
GRANT SELECT
    ON TurnierDB.venue       TO r_turnierveranstalter;

-- Spielberichtserstatter
-- Darf Ereignisse schreiben und Spielstände aktualisieren.
-- SELECT ist notwendig, um z. B. game_id oder player_id korrekt zu prüfen.
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.game_event TO r_spielberichtserstatter;
GRANT SELECT
    ON TurnierDB.player     TO r_spielberichtserstatter;
GRANT SELECT
    ON TurnierDB.game       TO r_spielberichtserstatter;

-- Einschränkte UPDATE-Rechte nur auf Scorefelder
GRANT UPDATE(home_score, away_score)
    ON TurnierDB.game TO r_spielberichtserstatter;

-- Viewer
-- Nur lesender Zugriff auf die gesamte Datenbank
GRANT SELECT
    ON TurnierDB.* TO r_viewer;

-- Datenpfleger
-- Darf Stammdaten pflegen: Sportarten, Saisons, Spielorte, Teams
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.sport TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE
    ON TurnierDB.season TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE, DELETE
    ON TurnierDB.venue TO r_datenpfleger;
GRANT SELECT, INSERT, UPDATE, DELETE
    ON TurnierDB.team TO r_datenpfleger;

-- Systemadministrator
-- Vollzugriff auf die gesamte Datenbank inkl. GRANT OPTION
GRANT ALL PRIVILEGES ON TurnierDB.*
    TO 'systemadministrator'@'%' WITH GRANT OPTION;
-- ---------------------------------------------------

-- Nutzer anlegen
CREATE OR REPLACE USER 'systemadministrator'@'%' IDENTIFIED BY 'secure_password';
CREATE OR REPLACE USER 'user_vereinsmanager'@'%' IDENTIFIED BY '';
CREATE OR REPLACE USER 'user_turnierveranstalter'@'%' IDENTIFIED BY '';
CREATE OR REPLACE USER 'user_spielberichterstatter'@'%' IDENTIFIED BY '';
CREATE OR REPLACE USER 'user_viewer'@'%' IDENTIFIED BY '';
CREATE OR REPLACE USER 'user_datenpfleger'@'%' IDENTIFIED BY '';

-- Rechte vergeben
GRANT r_vereinsmanager TO 'user_vereinsmanager'@'%';
SET DEFAULT ROLE r_vereinsmanager FOR 'user_vereinsmanager'@'%';

GRANT r_turnierveranstalter TO 'user_turnierveranstalter'@'%';
SET DEFAULT ROLE r_turnierveranstalter FOR 'user_turnierveranstalter'@'%';

GRANT r_spielberichtserstatter TO 'user_spielberichterstatter'@'%';
SET DEFAULT ROLE r_spielberichtserstatter FOR 'user_spielberichterstatter'@'%';

GRANT r_viewer TO 'user_viewer'@'%';
SET DEFAULT ROLE r_viewer FOR 'user_viewer'@'%';

GRANT r_datenpfleger TO 'user_datenpfleger'@'%';
SET DEFAULT ROLE r_datenpfleger FOR 'user_datenpfleger'@'%';


FLUSH PRIVILEGES;