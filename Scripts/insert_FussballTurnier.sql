USE TurnierDB;

-- ============================================================
-- 1) sport & season
-- ============================================================

INSERT INTO sport (name, default_team_size, is_indoor)
VALUES ('Fußball', 11, 0);

INSERT INTO season (name, start_date, end_date)
VALUES ('SoSe 2025', '2025-04-01', '2025-09-30');

-- ============================================================
-- 2) Competition
-- ============================================================

INSERT INTO competition (sport_id, season_id, name, level, gender_category, mode)
VALUES (
           (SELECT sport_id FROM sport WHERE name = 'Fußball'),
           (SELECT season_id FROM season WHERE name = 'SoSe 2025'),
           'Hochschulcup Fußball Herren SoSe 2025',
           'Hochschule',
           'Herren',
           'KO-Turnier (8 Teams)'
       );

-- ============================================================
-- 3) Venues (DHBW-Standorte)
-- ============================================================

INSERT INTO venue (name, city, capacity) VALUES
                                             ('DHBW Campus Arena Friedrichshafen', 'Friedrichshafen', 1500),
                                             ('DHBW Stadion Stuttgart-Vaihingen',  'Stuttgart',       2000),
                                             ('DHBW Sportpark Mannheim',           'Mannheim',        1800),
                                             ('DHBW Technik-Arena Karlsruhe',      'Karlsruhe',       1600),
                                             ('DHBW Med-Campus Mosbach',           'Mosbach',         1200),
                                             ('DHBW Soziales Park Heidenheim',     'Heidenheim',      1000),
                                             ('DHBW Business Arena Ravensburg',    'Ravensburg',      1400),
                                             ('DHBW Physikplatz Lörrach',          'Lörrach',         900);

-- ============================================================
-- 4) Teams (mit Heimvenue)
-- ============================================================

INSERT INTO team (name, short_name, home_venue_id) VALUES
                                                       ('Informatik Kickers DHBW Friedrichshafen', 'INF',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Campus Arena Friedrichshafen')),
                                                       ('Maschinenbau United DHBW Stuttgart', 'MCH',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Stadion Stuttgart-Vaihingen')),
                                                       ('Wirtschafts Allstars DHBW Mannheim', 'WIR',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Sportpark Mannheim')),
                                                       ('Elektro Technik 04 DHBW Karlsruhe', 'ELT',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Technik-Arena Karlsruhe')),
                                                       ('Mediziner FC DHBW Mosbach', 'MED',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Med-Campus Mosbach')),
                                                       ('Sozialpädagogik Rangers DHBW Heidenheim', 'SPR',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Soziales Park Heidenheim')),
                                                       ('BWL Tigers DHBW Ravensburg', 'BWL',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Business Arena Ravensburg')),
                                                       ('Physik Dynamo DHBW Lörrach', 'PHY',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Physikplatz Lörrach'));

-- ============================================================
-- 5) Players
-- ============================================================

-- INF: 100001–100011
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Lukas',  'Müller',    '100001', '2003-02-15', 'lukas.mueller@hs-example.de'),
                                                                                 ('Jonas',  'Schmidt',   '100002', '2002-11-03', 'jonas.schmidt@hs-example.de'),
                                                                                 ('Paul',   'Weber',     '100003', '2003-07-21', 'paul.weber@hs-example.de'),
                                                                                 ('Tim',    'Becker',    '100004', '2004-01-10', 'tim.becker@hs-example.de'),
                                                                                 ('Max',    'Klein',     '100005', '2003-05-08', 'max.klein@hs-example.de'),
                                                                                 ('Jan',    'Wolf',      '100006', '2002-09-19', 'jan.wolf@hs-example.de'),
                                                                                 ('Tom',    'Krämer',    '100007', '2003-03-25', 'tom.kraemer@hs-example.de'),
                                                                                 ('Leon',   'Hartmann',  '100008', '2003-12-30', 'leon.hartmann@hs-example.de'),
                                                                                 ('Niklas', 'Koch',      '100009', '2002-06-14', 'niklas.koch@hs-example.de'),
                                                                                 ('Milan',  'Zimmer',    '100010', '2003-08-02', 'milan.zimmer@hs-example.de'),
                                                                                 ('Fabian', 'Lange',     '100011', '2002-10-22', 'fabian.lange@hs-example.de');

-- MCH: 100101–100111
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('David',   'Hoffmann',  '100101', '2002-01-18', 'david.hoffmann@hs-example.de'),
                                                                                 ('Kevin',   'Schäfer',   '100102', '2003-03-09', 'kevin.schaefer@hs-example.de'),
                                                                                 ('Philipp', 'Maier',     '100103', '2002-07-27', 'philipp.maier@hs-example.de'),
                                                                                 ('Marco',   'Richter',   '100104', '2003-11-11', 'marco.richter@hs-example.de'),
                                                                                 ('Tobias',  'Arnold',    '100105', '2002-05-30', 'tobias.arnold@hs-example.de'),
                                                                                 ('Jannik',  'Schuster',  '100106', '2003-09-06', 'jannik.schuster@hs-example.de'),
                                                                                 ('Felix',   'Busch',     '100107', '2002-12-20', 'felix.busch@hs-example.de'),
                                                                                 ('Simon',   'Brandt',    '100108', '2003-04-13', 'simon.brandt@hs-example.de'),
                                                                                 ('Moritz',  'Peters',    '100109', '2002-08-15', 'moritz.peters@hs-example.de'),
                                                                                 ('Patrick', 'Lehmann',   '100110', '2003-06-01', 'patrick.lehmann@hs-example.de'),
                                                                                 ('Alexander','Voigt',    '100111', '2002-09-23', 'alexander.voigt@hs-example.de');

-- WIR: 100201–100211
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Johannes','Fischer',   '100201', '2003-02-02', 'johannes.fischer@hs-example.de'),
                                                                                 ('Sebastian','Lorenz',   '100202', '2002-12-05', 'sebastian.lorenz@hs-example.de'),
                                                                                 ('Dominik',  'Graf',     '100203', '2003-06-18', 'dominik.graf@hs-example.de'),
                                                                                 ('Christian','Pohl',     '100204', '2002-04-27', 'christian.pohl@hs-example.de'),
                                                                                 ('Martin',   'Kuhn',     '100205', '2003-10-09', 'martin.kuhn@hs-example.de'),
                                                                                 ('Daniel',   'Jäger',    '100206', '2002-07-16', 'daniel.jaeger@hs-example.de'),
                                                                                 ('Timo',     'Bauer',    '100207', '2003-03-01', 'timo.bauer@hs-example.de'),
                                                                                 ('Andreas',  'Scholz',   '100208', '2002-09-07', 'andreas.scholz@hs-example.de'),
                                                                                 ('Nico',     'Roth',     '100209', '2003-11-19', 'nico.roth@hs-example.de'),
                                                                                 ('Eric',     'Paulsen',  '100210', '2002-06-10', 'eric.paulsen@hs-example.de'),
                                                                                 ('Florian',  'Albrecht', '100211', '2002-10-28', 'florian.albrecht@hs-example.de');

-- ELT: 100301–100311
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Oliver','Krebs',       '100301', '2002-01-09', 'oliver.krebs@hs-example.de'),
                                                                                 ('Marcel','Berger',      '100302', '2003-05-14', 'marcel.berger@hs-example.de'),
                                                                                 ('Rene','Seidel',        '100303', '2002-08-22', 'rene.seidel@hs-example.de'),
                                                                                 ('Dennis','Walther',     '100304', '2003-02-28', 'dennis.walther@hs-example.de'),
                                                                                 ('Sven','Kaiser',        '100305', '2002-10-03', 'sven.kaiser@hs-example.de'),
                                                                                 ('Kai','Hauser',         '100306', '2003-07-19', 'kai.hauser@hs-example.de'),
                                                                                 ('Bastian','Funk',       '100307', '2002-03-25', 'bastian.funk@hs-example.de'),
                                                                                 ('Chris','Ullrich',      '100308', '2003-09-30', 'chris.ullrich@hs-example.de'),
                                                                                 ('Lennart','Kirsch',     '100309', '2002-05-05', 'lennart.kirsch@hs-example.de'),
                                                                                 ('Robin','Keller',       '100310', '2003-01-20', 'robin.keller@hs-example.de'),
                                                                                 ('Erik','Stahl',         '100311', '2002-11-29', 'erik.stahl@hs-example.de');

-- MED: 100401–100411
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Jonah','Arnold',       '100401', '2003-03-03', 'jonah.arnold@hs-example.de'),
                                                                                 ('Lars','Heinrich',      '100402', '2002-06-06', 'lars.heinrich@hs-example.de'),
                                                                                 ('Matthias','Stein',     '100403', '2003-09-09', 'matthias.stein@hs-example.de'),
                                                                                 ('Hendrik','Gebauer',    '100404', '2002-12-12', 'hendrik.gebauer@hs-example.de'),
                                                                                 ('Nils','Winter',        '100405', '2003-04-04', 'nils.winter@hs-example.de'),
                                                                                 ('Julius','Franke',      '100406', '2002-08-08', 'julius.franke@hs-example.de'),
                                                                                 ('Tobias','Michaelis',   '100407', '2003-11-11', 'tobias.michaelis@hs-example.de'),
                                                                                 ('Stefan','Haas',        '100408', '2002-02-02', 'stefan.haas@hs-example.de'),
                                                                                 ('Kilian','Kopp',        '100409', '2003-05-15', 'kilian.kopp@hs-example.de'),
                                                                                 ('Samuel','Thiel',       '100410', '2002-07-07', 'samuel.thiel@hs-example.de'),
                                                                                 ('Noah','Voß',           '100411', '2003-10-10', 'noah.voss@hs-example.de');

-- SPR: 100501–100511
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Emil','Berndt',        '100501', '2002-01-01', 'emil.berndt@hs-example.de'),
                                                                                 ('Lennox','Kolb',        '100502', '2003-03-05', 'lennox.kolb@hs-example.de'),
                                                                                 ('Mika','Holz',          '100503', '2002-06-06', 'mika.holz@hs-example.de'),
                                                                                 ('Theo','Kurz',          '100504', '2003-09-09', 'theo.kurz@hs-example.de'),
                                                                                 ('Janne','Wild',         '100505', '2002-11-14', 'janne.wild@hs-example.de'),
                                                                                 ('Keno','Groß',          '100506', '2003-02-19', 'keno.gross@hs-example.de'),
                                                                                 ('Hannes','Ortmann',     '100507', '2002-04-22', 'hannes.ortmann@hs-example.de'),
                                                                                 ('Lio','Rieger',         '100508', '2003-07-27', 'lio.rieger@hs-example.de'),
                                                                                 ('Malte','Dorn',         '100509', '2002-09-30', 'malte.dorn@hs-example.de'),
                                                                                 ('Joshua','Eggers',      '100510', '2003-12-12', 'joshua.eggers@hs-example.de'),
                                                                                 ('Adrian','Merkel',      '100511', '2002-03-03', 'adrian.merkel@hs-example.de');

-- BWL: 100601–100611
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Luis','Bach',          '100601', '2003-01-15', 'luis.bach@hs-example.de'),
                                                                                 ('Henry','Kastner',      '100602', '2002-04-17', 'henry.kastner@hs-example.de'),
                                                                                 ('Elias','Ritter',       '100603', '2003-06-19', 'elias.ritter@hs-example.de'),
                                                                                 ('Piet','Adam',          '100604', '2002-08-21', 'piet.adam@hs-example.de'),
                                                                                 ('Joel','Kunz',          '100605', '2003-10-23', 'joel.kunz@hs-example.de'),
                                                                                 ('Leonard','Faber',      '100606', '2002-12-25', 'leonard.faber@hs-example.de'),
                                                                                 ('Kian','Mohr',          '100607', '2003-02-27', 'kian.mohr@hs-example.de'),
                                                                                 ('Till','Herzog',        '100608', '2002-05-29', 'till.herzog@hs-example.de'),
                                                                                 ('Jason','Behrendt',     '100609', '2003-07-31', 'jason.behrendt@hs-example.de'),
                                                                                 ('Colin','Probst',       '100610', '2002-09-02', 'colin.probst@hs-example.de'),
                                                                                 ('Roman','Ziegler',      '100611', '2003-11-04', 'roman.ziegler@hs-example.de');

-- PHY: 100701–100711
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Finn','Wendt',         '100701', '2002-02-12', 'finn.wendt@hs-example.de'),
                                                                                 ('Karlo','Reuter',       '100702', '2003-04-14', 'karlo.reuter@hs-example.de'),
                                                                                 ('Anton','Ludwig',       '100703', '2002-06-16', 'anton.ludwig@hs-example.de'),
                                                                                 ('Levi','Hennig',        '100704', '2003-08-18', 'levi.hennig@hs-example.de'),
                                                                                 ('Matti','Kern',         '100705', '2002-10-20', 'matti.kern@hs-example.de'),
                                                                                 ('Jamie','Hauck',        '100706', '2003-12-22', 'jamie.hauck@hs-example.de'),
                                                                                 ('Peer','Nickel',        '100707', '2002-03-24', 'peer.nickel@hs-example.de'),
                                                                                 ('Bela','Kremer',        '100708', '2003-05-26', 'bela.kremer@hs-example.de'),
                                                                                 ('Joris','Rapp',         '100709', '2002-07-28', 'joris.rapp@hs-example.de'),
                                                                                 ('Keno','Grimm',         '100710', '2003-09-30', 'keno.grimm@hs-example.de'),
                                                                                 ('Lennard','Uhl',        '100711', '2002-11-01', 'lennard.uhl@hs-example.de');

-- ============================================================
-- 6) team_player:
-- ============================================================

-- INF
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100001'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100002'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100003'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100004'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100005'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100006'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100007'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100008'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100009'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100010'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'INF'), (SELECT player_id FROM player WHERE student_id = '100011'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- MCH
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100101'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100102'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100103'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100104'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100105'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100106'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100107'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100108'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100109'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100110'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MCH'), (SELECT player_id FROM player WHERE student_id = '100111'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- WIR
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100201'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100202'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100203'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100204'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100205'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100206'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100207'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100208'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100209'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100210'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'WIR'), (SELECT player_id FROM player WHERE student_id = '100211'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- ELT
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100301'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100302'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100303'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100304'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100305'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100306'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100307'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100308'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100309'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100310'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'ELT'), (SELECT player_id FROM player WHERE student_id = '100311'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- MED
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100401'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100402'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100403'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100404'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100405'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100406'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100407'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100408'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100409'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100410'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'MED'), (SELECT player_id FROM player WHERE student_id = '100411'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- SPR
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100501'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100502'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100503'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100504'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100505'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100506'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100507'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100508'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100509'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100510'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'SPR'), (SELECT player_id FROM player WHERE student_id = '100511'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- BWL
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100601'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100602'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100603'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100604'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100605'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100606'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100607'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100608'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100609'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100610'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWL'), (SELECT player_id FROM player WHERE student_id = '100611'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- PHY
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100701'), '2025-04-01 00:00:00', NULL, 1, 'Torwart'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100702'), '2025-04-01 00:00:00', NULL, 2, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100703'), '2025-04-01 00:00:00', NULL, 3, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100704'), '2025-04-01 00:00:00', NULL, 4, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100705'), '2025-04-01 00:00:00', NULL, 5, 'Verteidiger'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100706'), '2025-04-01 00:00:00', NULL, 6, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100707'), '2025-04-01 00:00:00', NULL, 7, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100708'), '2025-04-01 00:00:00', NULL, 8, 'Mittelfeld'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100709'), '2025-04-01 00:00:00', NULL, 9, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100710'), '2025-04-01 00:00:00', NULL, 10, 'Stürmer'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'PHY'), (SELECT player_id FROM player WHERE student_id = '100711'), '2025-04-01 00:00:00', NULL, 11, 'Stürmer');

-- ============================================================
-- 7) comp_team: alle Teams nehmen teil
-- ============================================================

INSERT INTO comp_team (competition_id, team_id, registration_date, group_name)
SELECT c.competition_id, t.team_id, '2025-03-15', NULL
FROM competition c
         JOIN team t
WHERE c.name = 'Hochschulcup Fußball Herren SoSe 2025';

-- ============================================================
-- 8) games: KO-Baum (Viertelfinale, Halbfinale, Finale)
-- ============================================================

INSERT INTO game (competition_id, venue_id, gameday_number, stage, scheduled_datetime,
                  away_team_id, home_team_id, home_score, away_score, status)
VALUES
    -- QF1: INF 3:1 MCH  (Heim: INF)
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'INF'),
        1, 'Viertelfinale', '2025-06-01 18:00:00',
        (SELECT team_id FROM team WHERE short_name = 'MCH'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        3, 1, 'Finished'
    ),
    -- QF2: ELT 2:0 WIR  (Heim: ELT)
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'ELT'),
        1, 'Viertelfinale', '2025-06-01 20:30:00',
        (SELECT team_id FROM team WHERE short_name = 'WIR'),
        (SELECT team_id FROM team WHERE short_name = 'ELT'),
        2, 0, 'Finished'
    ),
    -- QF3: MED 2:1 SPR  (Heim: MED)
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'MED'),
        1, 'Viertelfinale', '2025-06-02 18:00:00',
        (SELECT team_id FROM team WHERE short_name = 'SPR'),
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        2, 1, 'Finished'
    ),
    -- QF4: BWL 2:0 PHY  (Heim: BWL)  **korrigiert: 2:0 statt 0:2**
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'BWL'),
        1, 'Viertelfinale', '2025-06-02 20:30:00',
        (SELECT team_id FROM team WHERE short_name = 'PHY'),
        (SELECT team_id FROM team WHERE short_name = 'BWL'),
        2, 0, 'Finished'
    ),
    -- HF1: INF 2:1 ELT  (Sieger QF1 vs Sieger QF2, Heim: INF)
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'INF'),
        2, 'Halbfinale', '2025-06-05 18:00:00',
        (SELECT team_id FROM team WHERE short_name = 'ELT'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        2, 1, 'Finished'
    ),
    -- HF2: MED 1:0 BWL  (Sieger QF3 vs Sieger QF4, Heim: MED) **korrigiert: 1:0 statt 0:1**
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'MED'),
        2, 'Halbfinale', '2025-06-05 20:30:00',
        (SELECT team_id FROM team WHERE short_name = 'BWL'),
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        1, 0, 'Finished'
    ),
    -- Finale: INF 2:1 MED  (Sieger HF1 vs Sieger HF2, Heim: INF)
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Fußball Herren SoSe 2025'),
        (SELECT t.home_venue_id FROM team t WHERE t.short_name = 'INF'),
        3, 'Finale', '2025-06-10 19:30:00',
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        2, 1, 'Finished'
    );

-- ============================================================
-- 9) game_event
-- ============================================================

-- QF1: INF 3:1 MCH  → 4 Tore
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'INF' AND at.short_name = 'MCH'),
        15, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100009'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Fernschuss zum 1:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'INF' AND at.short_name = 'MCH'),
        30, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100005'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Kopfball nach Ecke zum 2:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'INF' AND at.short_name = 'MCH'),
        52, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100103'),
        (SELECT team_id FROM team WHERE short_name = 'MCH'),
        'Distanzschuss zum 2:1'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'INF' AND at.short_name = 'MCH'),
        88, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100007'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Kontertor zum 3:1 Endstand'
    );

-- QF2: ELT 2:0 WIR  → 2 Tore
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'ELT' AND at.short_name = 'WIR'),
        20, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100305'),
        (SELECT team_id FROM team WHERE short_name = 'ELT'),
        'Flachschuss ins Eck zum 1:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'ELT' AND at.short_name = 'WIR'),
        75, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100307'),
        (SELECT team_id FROM team WHERE short_name = 'ELT'),
        'Abstauber nach Abpraller zum 2:0'
    );

-- QF3: MED 2:1 SPR  → 3 Tore
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'MED' AND at.short_name = 'SPR'),
        10, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100405'),
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        'Direktabnahme zum 1:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'MED' AND at.short_name = 'SPR'),
        60, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100505'),
        (SELECT team_id FROM team WHERE short_name = 'SPR'),
        'Schuss aus kurzer Distanz zum 1:1'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'MED' AND at.short_name = 'SPR'),
        78, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100406'),
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        'Flachschuss ins Eck zum 2:1 Endstand'
    );

-- QF4: BWL 2:0 PHY  → 2 Tore
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'BWL' AND at.short_name = 'PHY'),
        25, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100605'),
        (SELECT team_id FROM team WHERE short_name = 'BWL'),
        'Kopfballtor nach Flanke zum 1:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Viertelfinale' AND ht.short_name = 'BWL' AND at.short_name = 'PHY'),
        70, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100609'),
        (SELECT team_id FROM team WHERE short_name = 'BWL'),
        'Schlenzer ins lange Eck zum 2:0'
    );

-- HF1: INF 2:1 ELT  → 3 Tore
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Halbfinale' AND ht.short_name = 'INF' AND at.short_name = 'ELT'),
        12, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100003'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Schuss aus spitzem Winkel zum 1:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Halbfinale' AND ht.short_name = 'INF' AND at.short_name = 'ELT'),
        50, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100303'),
        (SELECT team_id FROM team WHERE short_name = 'ELT'),
        'Ausgleichstreffer zum 1:1'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Halbfinale' AND ht.short_name = 'INF' AND at.short_name = 'ELT'),
        80, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100010'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Weitschuss zum 2:1 Endstand'
    );

-- HF2: MED 1:0 BWL  → 1 Tor
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Halbfinale' AND ht.short_name = 'MED' AND at.short_name = 'BWL'),
        40, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100401'),
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        'Flachschuss von der Strafraumkante zum 1:0'
    );

-- Finale: INF 2:1 MED  → 3 Tore
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Finale' AND ht.short_name = 'INF' AND at.short_name = 'MED'),
        22, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100010'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Abstauber nach Abpraller zum 1:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Finale' AND ht.short_name = 'INF' AND at.short_name = 'MED'),
        55, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100406'),
        (SELECT team_id FROM team WHERE short_name = 'MED'),
        'Ausgleich nach Steilpass zum 1:1'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
         WHERE g.stage = 'Finale' AND ht.short_name = 'INF' AND at.short_name = 'MED'),
        79, 'Tor',
        (SELECT player_id FROM player WHERE student_id = '100002'),
        (SELECT team_id FROM team WHERE short_name = 'INF'),
        'Direktabnahme im Strafraum zum 2:1'
    );
