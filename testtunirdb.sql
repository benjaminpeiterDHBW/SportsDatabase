-- MariaDB DDL script for "Sports Tournament Management Data Model"
-- Creates database and tables with constraints, indexes and sensible defaults.
-- Adjust names, lengths and ON DELETE behavior as needed for your application.

CREATE DATABASE IF NOT EXISTS `sports_tournaments`
    DEFAULT CHARACTER SET = utf8mb4
    DEFAULT COLLATE = utf8mb4_unicode_ci;
USE `sports_tournaments`;

-- ----------------------------------------------------
-- Helper: drop tables in dependency order (useful for re-run during development)
-- ----------------------------------------------------
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `standing`;
DROP TABLE IF EXISTS `event`;
DROP TABLE IF EXISTS `assignment`;
DROP TABLE IF EXISTS `match`;
DROP TABLE IF EXISTS `official`;
DROP TABLE IF EXISTS `venue`;
DROP TABLE IF EXISTS `roster`;
DROP TABLE IF EXISTS `player`;
DROP TABLE IF EXISTS `team`;
DROP TABLE IF EXISTS `tgroup`;
DROP TABLE IF EXISTS `phase`;
DROP TABLE IF EXISTS `tournament`;
DROP TABLE IF EXISTS `season`;
DROP TABLE IF EXISTS `sport`;
SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------
-- sport
-- ----------------------------------------------------
CREATE TABLE `sport` (
                         `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `name` VARCHAR(100) NOT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `ux_sport_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

-- ----------------------------------------------------
-- season
-- ----------------------------------------------------
CREATE TABLE `season` (
                          `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                          `name` VARCHAR(100) NOT NULL,
                          `start_date` DATE NOT NULL,
                          `end_date` DATE NOT NULL,
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `ux_season_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

-- ----------------------------------------------------
-- tournament
-- ----------------------------------------------------
CREATE TABLE `tournament` (
                              `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                              `sport_id` INT UNSIGNED NOT NULL,
                              `season_id` INT UNSIGNED NOT NULL,
                              `name` VARCHAR(200) NOT NULL,
                              `location` VARCHAR(200) NULL,
                              `start_dt` DATETIME NOT NULL,
                              `end_dt` DATETIME NOT NULL,
                              `ruleset_json` JSON NULL,
                              PRIMARY KEY (`id`),
                              KEY `fk_tournament_sport_idx` (`sport_id`),
                              KEY `fk_tournament_season_idx` (`season_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

ALTER TABLE `tournament`
    ADD CONSTRAINT `fk_tournament_sport`
        FOREIGN KEY (`sport_id`) REFERENCES `sport` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    ADD CONSTRAINT `fk_tournament_season`
        FOREIGN KEY (`season_id`) REFERENCES `season` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------
-- phase
-- ----------------------------------------------------
CREATE TABLE `phase` (
                         `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `tournament_id` INT UNSIGNED NOT NULL,
                         `type` VARCHAR(50) NOT NULL, -- e.g., "group", "knockout", "playoff"
                         `seq_no` INT UNSIGNED NOT NULL DEFAULT 0,
                         PRIMARY KEY (`id`),
                         KEY `fk_phase_tournament_idx` (`tournament_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

ALTER TABLE `phase`
    ADD CONSTRAINT `fk_phase_tournament`
        FOREIGN KEY (`tournament_id`) REFERENCES `tournament` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE;

-- ----------------------------------------------------
-- tgroup (tournament group)
-- ----------------------------------------------------
CREATE TABLE `tgroup` (
                          `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                          `phase_id` INT UNSIGNED NOT NULL,
                          `name` VARCHAR(100) NOT NULL,
                          PRIMARY KEY (`id`),
                          KEY `fk_tgroup_phase_idx` (`phase_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

ALTER TABLE `tgroup`
    ADD CONSTRAINT `fk_tgroup_phase`
        FOREIGN KEY (`phase_id`) REFERENCES `phase` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE;

-- ----------------------------------------------------
-- team
-- ----------------------------------------------------
CREATE TABLE `team` (
                        `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                        `name` VARCHAR(150) NOT NULL,
                        `club` VARCHAR(150) NULL,
                        `country` VARCHAR(100) NULL,
                        PRIMARY KEY (`id`),
                        UNIQUE KEY `ux_team_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

-- ----------------------------------------------------
-- player
-- ----------------------------------------------------
CREATE TABLE `player` (
                          `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                          `full_name` VARCHAR(200) NOT NULL,
                          `birth_year` SMALLINT UNSIGNED NULL,
                          `nationality` VARCHAR(100) NULL,
                          PRIMARY KEY (`id`),
                          KEY `idx_player_name` (`full_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

-- ----------------------------------------------------
-- roster
-- ----------------------------------------------------
CREATE TABLE `roster` (
                          `team_id` INT UNSIGNED NOT NULL,
                          `player_id` INT UNSIGNED NOT NULL,
                          `from_dt` DATE NOT NULL,
                          `to_dt` DATE NULL,
                          `role` VARCHAR(50) NULL, -- e.g., "player", "captain", "substitute"
                          PRIMARY KEY (`team_id`, `player_id`, `from_dt`),
                          KEY `fk_roster_team_idx` (`team_id`),
                          KEY `fk_roster_player_idx` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

ALTER TABLE `roster`
    ADD CONSTRAINT `fk_roster_team`
        FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT `fk_roster_player`
        FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE;

-- ----------------------------------------------------
-- venue
-- ----------------------------------------------------
CREATE TABLE `venue` (
                         `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `name` VARCHAR(200) NOT NULL,
                         `city` VARCHAR(100) NULL,
                         `capacity` INT UNSIGNED NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `ux_venue_name_city` (`name`, `city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='';

-- ----------------------------------------------------
-- official
-- ----------------------------------------------------
CREATE TABLE `official` (
                            `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                            `full_name` VARCHAR(200) NOT NULL,
                            `role` VARCHAR(100) NULL, -- e.g., "referee", "linesman", "scorekeeper"
                            PRIMARY KEY (`id`),
                            KEY `idx_official_name` (`full_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='icon: user-check, color: pink';

-- ----------------------------------------------------
-- match
-- ----------------------------------------------------
CREATE TABLE `match` (
                         `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `phase_id` INT UNSIGNED NOT NULL,
                         `group_id` INT UNSIGNED NULL,
                         `venue_id` INT UNSIGNED NULL,
                         `home_team_id` INT UNSIGNED NOT NULL,
                         `away_team_id` INT UNSIGNED NOT NULL,
                         `start_dt` DATETIME NOT NULL,
                         `status` ENUM('scheduled','ongoing','finished','cancelled') NOT NULL DEFAULT 'scheduled',
                         PRIMARY KEY (`id`),
                         KEY `fk_match_phase_idx` (`phase_id`),
                         KEY `fk_match_group_idx` (`group_id`),
                         KEY `fk_match_venue_idx` (`venue_id`),
                         KEY `fk_match_home_team_idx` (`home_team_id`),
                         KEY `fk_match_away_team_idx` (`away_team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='icon: calendar, color: brown';

ALTER TABLE `match`
    ADD CONSTRAINT `fk_match_phase`
        FOREIGN KEY (`phase_id`) REFERENCES `phase` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    ADD CONSTRAINT `fk_match_group`
        FOREIGN KEY (`group_id`) REFERENCES `tgroup` (`id`)
            ON UPDATE CASCADE ON DELETE SET NULL,
    ADD CONSTRAINT `fk_match_venue`
        FOREIGN KEY (`venue_id`) REFERENCES `venue` (`id`)
            ON UPDATE CASCADE ON DELETE SET NULL,
    ADD CONSTRAINT `fk_match_home_team`
        FOREIGN KEY (`home_team_id`) REFERENCES `team` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT,
    ADD CONSTRAINT `fk_match_away_team`
        FOREIGN KEY (`away_team_id`) REFERENCES `team` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------
-- assignment (official assignment for a match)
-- ----------------------------------------------------
CREATE TABLE `assignment` (
                              `match_id` INT UNSIGNED NOT NULL,
                              `official_id` INT UNSIGNED NOT NULL,
                              `duty` VARCHAR(100) NULL,
                              PRIMARY KEY (`match_id`, `official_id`),
                              KEY `fk_assignment_match_idx` (`match_id`),
                              KEY `fk_assignment_official_idx` (`official_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='icon: check-square, color: violet';

ALTER TABLE `assignment`
    ADD CONSTRAINT `fk_assignment_match`
        FOREIGN KEY (`match_id`) REFERENCES `match` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT `fk_assignment_official`
        FOREIGN KEY (`official_id`) REFERENCES `official` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------
-- event (game events: goals, cards, substitutions, etc.)
-- ----------------------------------------------------
-- Note: MariaDB does not have an INTERVAL column type. Use TIME to represent time-in-match
-- or use integer seconds depending on precision needed. Here we use TIME for readability.
CREATE TABLE `event` (
                         `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                         `match_id` INT UNSIGNED NOT NULL,
                         `team_id` INT UNSIGNED NULL,
                         `player_id` INT UNSIGNED NULL,
                         `t_in_match` TIME NULL, -- e.g., '00:23:45' or '00:12:00' (minute:second)
                         `type` VARCHAR(50) NOT NULL, -- e.g., "goal","yellow_card","substitution"
                         `value` INT NULL,            -- optional numeric value: e.g., goal number, card severity, substitute jersey #
                         PRIMARY KEY (`id`),
                         KEY `fk_event_match_idx` (`match_id`),
                         KEY `fk_event_team_idx` (`team_id`),
                         KEY `fk_event_player_idx` (`player_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='icon: alert-circle, color: black';

ALTER TABLE `event`
    ADD CONSTRAINT `fk_event_match`
        FOREIGN KEY (`match_id`) REFERENCES `match` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT `fk_event_team`
        FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
            ON UPDATE CASCADE ON DELETE SET NULL,
    ADD CONSTRAINT `fk_event_player`
        FOREIGN KEY (`player_id`) REFERENCES `player` (`id`)
            ON UPDATE CASCADE ON DELETE SET NULL;

-- ----------------------------------------------------
-- standing
-- ----------------------------------------------------
CREATE TABLE `standing` (
                            `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
                            `group_id` INT UNSIGNED NOT NULL,
                            `team_id` INT UNSIGNED NOT NULL,
                            `points` INT NOT NULL DEFAULT 0,
                            `gf` INT NOT NULL DEFAULT 0, -- goals for
                            `ga` INT NOT NULL DEFAULT 0, -- goals against
                            `gd` INT NOT NULL DEFAULT 0, -- goal difference
                            `rank` INT NULL,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `ux_standing_group_team` (`group_id`, `team_id`),
                            KEY `fk_standing_group_idx` (`group_id`),
                            KEY `fk_standing_team_idx` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci
    COMMENT='icon: bar-chart, color: indigo';

ALTER TABLE `standing`
    ADD CONSTRAINT `fk_standing_group`
        FOREIGN KEY (`group_id`) REFERENCES `tgroup` (`id`)
            ON UPDATE CASCADE ON DELETE CASCADE,
    ADD CONSTRAINT `fk_standing_team`
        FOREIGN KEY (`team_id`) REFERENCES `team` (`id`)
            ON UPDATE CASCADE ON DELETE RESTRICT;

-- ----------------------------------------------------
-- Useful example indices for common queries
-- ----------------------------------------------------
CREATE INDEX `idx_match_start_dt` ON `match` (`start_dt`);
CREATE INDEX `idx_tournament_dates` ON `tournament` (`start_dt`, `end_dt`);
CREATE INDEX `idx_player_birth_year` ON `player` (`birth_year`);

-- ----------------------------------------------------
-- End of script
-- ----------------------------------------------------
