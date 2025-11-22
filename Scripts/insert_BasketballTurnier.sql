USE TurnierDB;

-- ============================================================
-- 1) Sport: Basketball
-- ============================================================

INSERT INTO sport (name, default_team_size, is_indoor)
VALUES ('Basketball', 5, 1);

-- ============================================================
-- 2) Competition: Hochschulcup Basketball Herren SoSe 2025
--    (Season 'SoSe 2025' muss bereits existieren)
-- ============================================================

INSERT INTO competition (sport_id, season_id, name, level, gender_category, mode)
VALUES (
           (SELECT sport_id FROM sport WHERE name = 'Basketball'),
           (SELECT season_id FROM season WHERE name = 'SoSe 2025'),
           'Hochschulcup Basketball Herren SoSe 2025',
           'Hochschule',
           'Herren',
           'KO-Turnier (8 Teams)'
       );

-- ============================================================
-- 3) Basketball-Teams (DHBW-Standorte, Venues existieren schon)
-- ============================================================

INSERT INTO team (name, short_name, home_venue_id) VALUES
                                                       ('Informatik Baskets DHBW Friedrichshafen', 'BINF',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Campus Arena Friedrichshafen')),
                                                       ('Maschinenbau Dunkers DHBW Stuttgart', 'BMCH',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Stadion Stuttgart-Vaihingen')),
                                                       ('Wirtschafts Bulls DHBW Mannheim', 'BWIR',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Sportpark Mannheim')),
                                                       ('Elektro Sparks DHBW Karlsruhe', 'BELT',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Technik-Arena Karlsruhe')),
                                                       ('Mediziner Giants DHBW Mosbach', 'BMED',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Med-Campus Mosbach')),
                                                       ('Sozialpädagogik Hoops DHBW Heidenheim', 'BSPR',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Soziales Park Heidenheim')),
                                                       ('BWL Rockets DHBW Ravensburg', 'BBWL',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Business Arena Ravensburg')),
                                                       ('Physik Lightning DHBW Lörrach', 'BPHY',
                                                        (SELECT venue_id FROM venue WHERE name = 'DHBW Physikplatz Lörrach'));

-- ============================================================
-- 4) Spieler für Basketball (8 Spieler pro Team, IDs 300xxx)
-- ============================================================

-- BINF 300001–300008
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Luka',   'Möller',    '300001', '2003-01-10', 'luka.moeller@hs-example.de'),
                                                                                 ('Nico',   'Schwarz',   '300002', '2002-05-12', 'nico.schwarz@hs-example.de'),
                                                                                 ('Robin',  'Klein',     '300003', '2003-07-18', 'robin.klein@hs-example.de'),
                                                                                 ('Timo',   'Franz',     '300004', '2002-09-22', 'timo.franz@hs-example.de'),
                                                                                 ('Jannik', 'Kurz',      '300005', '2003-11-03', 'jannik.kurz@hs-example.de'),
                                                                                 ('Malte',  'Hahn',      '300006', '2002-03-27', 'malte.hahn@hs-example.de'),
                                                                                 ('Kilian', 'Hartwig',   '300007', '2003-02-14', 'kilian.hartwig@hs-example.de'),
                                                                                 ('Jonas',  'Engel',     '300008', '2002-08-30', 'jonas.engel@hs-example.de');

-- BMCH 300101–300108
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('David',  'Ulrich',    '300101', '2002-04-04', 'david.ulrich@hs-example.de'),
                                                                                 ('Phil',   'Reiter',    '300102', '2003-06-06', 'phil.reiter@hs-example.de'),
                                                                                 ('Marc',   'Stange',    '300103', '2002-10-10', 'marc.stange@hs-example.de'),
                                                                                 ('Leo',    'Scholl',    '300104', '2003-01-20', 'leo.scholl@hs-example.de'),
                                                                                 ('Eric',   'Mertens',   '300105', '2002-12-01', 'eric.mertens@hs-example.de'),
                                                                                 ('Pascal', 'Kopp',      '300106', '2003-03-03', 'pascal.kopp@hs-example.de'),
                                                                                 ('Janis',  'Rehm',      '300107', '2002-07-15', 'janis.rehm@hs-example.de'),
                                                                                 ('Tom',    'Brenner',   '300108', '2003-09-09', 'tom.brenner@hs-example.de');

-- BWIR 300201–300208
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Sebastian','Schilling','300201','2002-02-02','sebastian.schilling@hs-example.de'),
                                                                                 ('Chris',    'Voigt',    '300202','2003-03-13','chris.voigt@hs-example.de'),
                                                                                 ('Jan',      'Bauer',    '300203','2002-06-25','jan.bauer@hs-example.de'),
                                                                                 ('Timo',     'Brand',    '300204','2003-08-08','timo.brand@hs-example.de'),
                                                                                 ('Florian',  'Kern',     '300205','2002-11-11','florian.kern@hs-example.de'),
                                                                                 ('Nils',     'Röder',    '300206','2003-05-05','nils.roeder@hs-example.de'),
                                                                                 ('Jonah',    'Döring',   '300207','2002-09-19','jonah.doering@hs-example.de'),
                                                                                 ('Louis',    'Kraus',    '300208','2003-12-21','louis.kraus@hs-example.de');

-- BELT 300301–300308
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Mika',   'Herbst',   '300301','2002-01-30','mika.herbst@hs-example.de'),
                                                                                 ('Levin',  'Fischer',  '300302','2003-03-16','levin.fischer@hs-example.de'),
                                                                                 ('Jonas',  'Ebert',    '300303','2002-05-28','jonas.ebert@hs-example.de'),
                                                                                 ('Tobias', 'Kaufmann', '300304','2003-07-07','tobias.kaufmann@hs-example.de'),
                                                                                 ('Simon',  'Heck',     '300305','2002-09-09','simon.heck@hs-example.de'),
                                                                                 ('Moritz', 'Neumann',  '300306','2003-11-25','moritz.neumann@hs-example.de'),
                                                                                 ('Keno',   'Fritz',    '300307','2002-04-14','keno.fritz@hs-example.de'),
                                                                                 ('Bjarne', 'Schütz',   '300308','2003-10-02','bjarne.schuetz@hs-example.de');

-- BMED 300401–300408
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Lars',    'Jacob',   '300401','2002-02-18','lars.jacob@hs-example.de'),
                                                                                 ('Marius',  'Hauser',  '300402','2003-04-22','marius.hauser@hs-example.de'),
                                                                                 ('Nico',    'Weiss',   '300403','2002-06-06','nico.weiss@hs-example.de'),
                                                                                 ('Kilian',  'Brandt',  '300404','2003-08-18','kilian.brandt@hs-example.de'),
                                                                                 ('Robin',   'Pfeifer', '300405','2002-10-20','robin.pfeifer@hs-example.de'),
                                                                                 ('Jonas',   'Gerber',  '300406','2003-12-12','jonas.gerber@hs-example.de'),
                                                                                 ('Tarek',   'Franz',   '300407','2002-03-03','tarek.franz@hs-example.de'),
                                                                                 ('Emil',    'Klaus',   '300408','2003-09-15','emil.klaus@hs-example.de');

-- BSPR 300501–300508
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Janne',  'Kurz',     '300501','2002-01-05','janne.kurz@hs-example.de'),
                                                                                 ('Theo',   'Meyer',    '300502','2003-03-08','theo.meyer@hs-example.de'),
                                                                                 ('Malte',  'Kopp',     '300503','2002-05-19','malte.kopp@hs-example.de'),
                                                                                 ('Lio',    'Hoffmann', '300504','2003-07-24','lio.hoffmann@hs-example.de'),
                                                                                 ('Hannes', 'Dietz',    '300505','2002-09-29','hannes.dietz@hs-example.de'),
                                                                                 ('Keno',   'Bock',     '300506','2003-11-11','keno.bock@hs-example.de'),
                                                                                 ('Joshua', 'Sander',   '300507','2002-04-09','joshua.sander@hs-example.de'),
                                                                                 ('Adrian', 'Kurzweg',  '300508','2003-10-30','adrian.kurzweg@hs-example.de');

-- BBWL 300601–300608
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Luis',    'Roth',    '300601','2003-02-02','luis.roth@hs-example.de'),
                                                                                 ('Henry',   'Maas',    '300602','2002-04-14','henry.maas@hs-example.de'),
                                                                                 ('Elias',   'Dorn',    '300603','2003-06-16','elias.dorn@hs-example.de'),
                                                                                 ('Piet',    'Groß',    '300604','2002-08-28','piet.gross@hs-example.de'),
                                                                                 ('Joel',    'Winter',  '300605','2003-10-10','joel.winter@hs-example.de'),
                                                                                 ('Leonard', 'Keller',  '300606','2002-12-22','leonard.keller@hs-example.de'),
                                                                                 ('Kian',    'Moos',    '300607','2003-03-04','kian.moos@hs-example.de'),
                                                                                 ('Till',    'Reich',   '300608','2002-05-06','till.reich@hs-example.de');

-- BPHY 300701–300708
INSERT INTO player (first_name, last_name, student_id, date_of_birth, email) VALUES
                                                                                 ('Finn',   'Zöller',   '300701','2002-02-12','finn.zoeller@hs-example.de'),
                                                                                 ('Karlo',  'Reimann',  '300702','2003-04-14','karlo.reimann@hs-example.de'),
                                                                                 ('Anton',  'Beck',     '300703','2002-06-16','anton.beck@hs-example.de'),
                                                                                 ('Levi',   'Schütz',   '300704','2003-08-18','levi.schuetz@hs-example.de'),
                                                                                 ('Matti',  'Bosch',    '300705','2002-10-20','matti.bosch@hs-example.de'),
                                                                                 ('Jamie',  'Voß',      '300706','2003-12-22','jamie.voss@hs-example.de'),
                                                                                 ('Peer',   'Henze',    '300707','2002-03-24','peer.henze@hs-example.de'),
                                                                                 ('Bela',   'Graf',     '300708','2003-05-26','bela.graf@hs-example.de');

-- ============================================================
-- 5) team_player: Zuordnung der Basketballspieler
-- ============================================================

-- BINF
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300001'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300002'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300003'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300004'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300005'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300006'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300007'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BINF'), (SELECT player_id FROM player WHERE student_id = '300008'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BMCH
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300101'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300102'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300103'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300104'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300105'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300106'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300107'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMCH'), (SELECT player_id FROM player WHERE student_id = '300108'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BWIR
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300201'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300202'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300203'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300204'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300205'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300206'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300207'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BWIR'), (SELECT player_id FROM player WHERE student_id = '300208'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BELT
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300301'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300302'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300303'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300304'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300305'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300306'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300307'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BELT'), (SELECT player_id FROM player WHERE student_id = '300308'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BMED
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300401'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300402'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300403'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300404'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300405'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300406'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300407'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BMED'), (SELECT player_id FROM player WHERE student_id = '300408'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BSPR
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300501'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300502'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300503'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300504'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300505'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300506'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300507'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BSPR'), (SELECT player_id FROM player WHERE student_id = '300508'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BBWL
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300601'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300602'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300603'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300604'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300605'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300606'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300607'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BBWL'), (SELECT player_id FROM player WHERE student_id = '300608'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- BPHY
INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300701'), '2025-04-01 00:00:00', NULL, 4, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300702'), '2025-04-01 00:00:00', NULL, 5, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300703'), '2025-04-01 00:00:00', NULL, 6, 'Guard'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300704'), '2025-04-01 00:00:00', NULL, 7, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300705'), '2025-04-01 00:00:00', NULL, 8, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300706'), '2025-04-01 00:00:00', NULL, 9, 'Forward'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300707'), '2025-04-01 00:00:00', NULL, 10, 'Center'),
                                                                                              ((SELECT team_id FROM team WHERE short_name = 'BPHY'), (SELECT player_id FROM player WHERE student_id = '300708'), '2025-04-01 00:00:00', NULL, 11, 'Center');

-- ============================================================
-- 6) Doppelbelastung: Fußballspieler spielen auch Basketball
--    (Spieler aus dem Fußballturnier müssen schon existieren)
-- ============================================================

INSERT INTO team_player (team_id, player_id, from_date, to_date, jersey_number, position) VALUES
                                                                                              (
                                                                                                  (SELECT team_id FROM team WHERE short_name = 'BINF'),
                                                                                                  (SELECT player_id FROM player WHERE student_id = '100001'),
                                                                                                  '2025-04-01 00:00:00', NULL, 12, 'Guard'
                                                                                              ),
                                                                                              (
                                                                                                  (SELECT team_id FROM team WHERE short_name = 'BINF'),
                                                                                                  (SELECT player_id FROM player WHERE student_id = '100009'),
                                                                                                  '2025-04-01 00:00:00', NULL, 13, 'Guard'
                                                                                              ),
                                                                                              (
                                                                                                  (SELECT team_id FROM team WHERE short_name = 'BBWL'),
                                                                                                  (SELECT player_id FROM player WHERE student_id = '100601'),
                                                                                                  '2025-04-01 00:00:00', NULL, 12, 'Forward'
                                                                                              ),
                                                                                              (
                                                                                                  (SELECT team_id FROM team WHERE short_name = 'BPHY'),
                                                                                                  (SELECT player_id FROM player WHERE student_id = '100701'),
                                                                                                  '2025-04-01 00:00:00', NULL, 12, 'Guard'
                                                                                              );

-- ============================================================
-- 7) comp_team: alle 8 Basketballteams in der Competition
-- ============================================================

INSERT INTO comp_team (competition_id, team_id, registration_date, group_name)
SELECT c.competition_id, t.team_id, '2025-04-15', NULL
FROM competition c
         JOIN team t ON t.short_name IN ('BINF','BMCH','BWIR','BELT','BMED','BSPR','BBWL','BPHY')
WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025';

-- ============================================================
-- 8) games: KO-Baum
--    Viertelfinale gespielt, Halbfinale angesetzt (Turnier läuft)
-- ============================================================

-- QF1: BINF (Heim) 4 : 3 BMCH
-- QF2: BWIR (Heim) 5 : 2 BELT
-- QF3: BMED (Heim) 6 : 4 BSPR
-- QF4: BBWL (Heim) 3 : 1 BPHY
-- HF1: BINF (Heim) vs BWIR (Auswärts) -> Scheduled, keine Scores
-- HF2: BMED (Heim) vs BBWL (Auswärts) -> Scheduled, keine Scores

INSERT INTO game (competition_id, venue_id, gameday_number, stage, scheduled_datetime,
                  away_team_id, home_team_id, home_score, away_score, status)
VALUES
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'),
        (SELECT venue_id FROM venue WHERE name = 'DHBW Campus Arena Friedrichshafen'),
        1, 'Viertelfinale', '2025-07-01 18:00:00',
        (SELECT team_id FROM team WHERE short_name = 'BMCH'),
        (SELECT team_id FROM team WHERE short_name = 'BINF'),
        4, 3, 'Finished'
    ),
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'),
        (SELECT venue_id FROM venue WHERE name = 'DHBW Campus Arena Friedrichshafen'),
        1, 'Viertelfinale', '2025-07-01 20:30:00',
        (SELECT team_id FROM team WHERE short_name = 'BELT'),
        (SELECT team_id FROM team WHERE short_name = 'BWIR'),
        5, 2, 'Finished'
    ),
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'),
        (SELECT venue_id FROM venue WHERE name = 'DHBW Sportpark Mannheim'),
        1, 'Viertelfinale', '2025-07-02 18:00:00',
        (SELECT team_id FROM team WHERE short_name = 'BSPR'),
        (SELECT team_id FROM team WHERE short_name = 'BMED'),
        6, 4, 'Finished'
    ),
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'),
        (SELECT venue_id FROM venue WHERE name = 'DHBW Technik-Arena Karlsruhe'),
        1, 'Viertelfinale', '2025-07-02 20:30:00',
        (SELECT team_id FROM team WHERE short_name = 'BPHY'),
        (SELECT team_id FROM team WHERE short_name = 'BBWL'),
        3, 1, 'Finished'
    ),
-- Halbfinals: Turnier im Gange, noch keine Scores/Events
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'),
        (SELECT venue_id FROM venue WHERE name = 'DHBW Campus Arena Friedrichshafen'),
        2, 'Halbfinale', '2025-07-05 18:00:00',
        (SELECT team_id FROM team WHERE short_name = 'BWIR'),
        (SELECT team_id FROM team WHERE short_name = 'BINF'),
        NULL, NULL, 'Scheduled'
    ),
    (
        (SELECT competition_id FROM competition WHERE name = 'Hochschulcup Basketball Herren SoSe 2025'),
        (SELECT venue_id FROM venue WHERE name = 'DHBW Campus Arena Friedrichshafen'),
        2, 'Halbfinale', '2025-07-05 20:30:00',
        (SELECT team_id FROM team WHERE short_name = 'BBWL'),
        (SELECT team_id FROM team WHERE short_name = 'BMED'),
        NULL, NULL, 'Scheduled'
    );

-- ============================================================
-- 9) game_event: Basketball-Events mit Punktetypen
--    Punktesumme je Team = home_score / away_score
-- ============================================================

-- QF1: BINF 4 : 3 BMCH  (BINF: 2+2, BMCH: 3)
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BINF'
           AND at.short_name = 'BMCH'),
        2, '2-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300001'),
        (SELECT team_id FROM team WHERE short_name = 'BINF'),
        'Drive zum Korb, 2 Punkte zum 2:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BINF'
           AND at.short_name = 'BMCH'),
        6, '2-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300002'),
        (SELECT team_id FROM team WHERE short_name = 'BINF'),
        'Midrange-Jumper zum 4:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BINF'
           AND at.short_name = 'BMCH'),
        10, '3-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300101'),
        (SELECT team_id FROM team WHERE short_name = 'BMCH'),
        'Dreier von der Birne zum 4:3 Endstand'
    );

-- QF2: BWIR 5 : 2 BELT  (BWIR: 3+2, BELT: 2)
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BWIR'
           AND at.short_name = 'BELT'),
        3, '3-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300201'),
        (SELECT team_id FROM team WHERE short_name = 'BWIR'),
        'Dreipunktewurf zum 3:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BWIR'
           AND at.short_name = 'BELT'),
        7, '2-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300202'),
        (SELECT team_id FROM team WHERE short_name = 'BWIR'),
        'Layup im Fastbreak zum 5:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BWIR'
           AND at.short_name = 'BELT'),
        12, '2-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300301'),
        (SELECT team_id FROM team WHERE short_name = 'BELT'),
        'Jumpshot aus der Mitteldistanz zum 5:2 Endstand'
    );

-- QF3: BMED 6 : 4 BSPR (BMED: 3+3, BSPR: 2+2)
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
-- 3:0 BMED
(
    (SELECT g.game_id FROM game g
                               JOIN team ht ON g.home_team_id = ht.team_id
                               JOIN team at ON g.away_team_id = at.team_id
                               JOIN competition c ON g.competition_id = c.competition_id
     WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
       AND g.stage = 'Viertelfinale'
       AND ht.short_name = 'BMED'
       AND at.short_name = 'BSPR'),
    2, '3-Punkte-Wurf',
    (SELECT player_id FROM player WHERE student_id = '300401'),
    (SELECT team_id FROM team WHERE short_name = 'BMED'),
    'Dreier von der Seite zum 3:0'
),
-- 3:2 BSPR
(
    (SELECT g.game_id FROM game g
                               JOIN team ht ON g.home_team_id = ht.team_id
                               JOIN team at ON g.away_team_id = at.team_id
                               JOIN competition c ON g.competition_id = c.competition_id
     WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
       AND g.stage = 'Viertelfinale'
       AND ht.short_name = 'BMED'
       AND at.short_name = 'BSPR'),
    5, '2-Punkte-Wurf',
    (SELECT player_id FROM player WHERE student_id = '300501'),
    (SELECT team_id FROM team WHERE short_name = 'BSPR'),
    'Drive zum Korb zum 3:2'
),
-- 6:2 BMED
(
    (SELECT g.game_id FROM game g
                               JOIN team ht ON g.home_team_id = ht.team_id
                               JOIN team at ON g.away_team_id = at.team_id
                               JOIN competition c ON g.competition_id = c.competition_id
     WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
       AND g.stage = 'Viertelfinale'
       AND ht.short_name = 'BMED'
       AND at.short_name = 'BSPR'),
    9, '3-Punkte-Wurf',
    (SELECT player_id FROM player WHERE student_id = '300402'),
    (SELECT team_id FROM team WHERE short_name = 'BMED'),
    'Stepback-Dreier zum 6:2'
),
-- 6:4 BSPR
(
    (SELECT g.game_id FROM game g
                               JOIN team ht ON g.home_team_id = ht.team_id
                               JOIN team at ON g.away_team_id = at.team_id
                               JOIN competition c ON g.competition_id = c.competition_id
     WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
       AND g.stage = 'Viertelfinale'
       AND ht.short_name = 'BMED'
       AND at.short_name = 'BSPR'),
    14, '2-Punkte-Wurf',
    (SELECT player_id FROM player WHERE student_id = '300502'),
    (SELECT team_id FROM team WHERE short_name = 'BSPR'),
    'Pull-up-Jumper zum 6:4 Endstand'
);

-- QF4: BBWL 3 : 1 BPHY  (BBWL: 3, BPHY: 1 Freiwwurf)
INSERT INTO game_event (game_id, event_minute, event_type, player_id, team_id, description)
VALUES
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BBWL'
           AND at.short_name = 'BPHY'),
        4, '3-Punkte-Wurf',
        (SELECT player_id FROM player WHERE student_id = '300601'),
        (SELECT team_id FROM team WHERE short_name = 'BBWL'),
        'Catch-and-Shoot Dreier zum 3:0'
    ),
    (
        (SELECT g.game_id FROM game g
                                   JOIN team ht ON g.home_team_id = ht.team_id
                                   JOIN team at ON g.away_team_id = at.team_id
                                   JOIN competition c ON g.competition_id = c.competition_id
         WHERE c.name = 'Hochschulcup Basketball Herren SoSe 2025'
           AND g.stage = 'Viertelfinale'
           AND ht.short_name = 'BBWL'
           AND at.short_name = 'BPHY'),
        11, 'Freiwurf',
        (SELECT player_id FROM player WHERE student_id = '300701'),
        (SELECT team_id FROM team WHERE short_name = 'BPHY'),
        'Verwandelter Freiwurf zum 3:1 Endstand'
    );
