psql --username=freecodecamp --dbname=postgres

CREATE DATABASE universe;

\c universe;



CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    galaxy_type VARCHAR(60) NOT NULL,
    galaxy_diameter INT NOT NULL CHECK (galaxy_diameter > 0),
    star_numbers NUMERIC(15,2) NOT NULL CHECK (star_numbers > 0),
    description TEXT
);

CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    spectral_type VARCHAR(10) NOT NULL,
    star_size FLOAT NOT NULL CHECK (star_size > 0),
    luminosity NUMERIC(9,2) NOT NULL CHECK (luminosity > 0),
    is_sun BOOLEAN NOT NULL,
    galaxy_id INT NOT NULL,
    FOREIGN KEY (galaxy_id) REFERENCES galaxy(galaxy_id)
);

CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    sun_distance NUMERIC(11,2) NOT NULL CHECK (sun_distance >= 0),
    diameter INT NOT NULL CHECK (diameter > 0),
    probability_of_life BOOLEAN NOT NULL,
    star_id INT NOT NULL,
    FOREIGN KEY (star_id) REFERENCES star(star_id)
);

CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL,
    planet_distance INT NOT NULL CHECK (planet_distance >= 0),
    unit_distance VARCHAR(10) NOT NULL,
    diameter INT NOT NULL CHECK (diameter > 0),
    unit_diameter VARCHAR(10) NOT NULL,
    planet_id INT NOT NULL,
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id)
);

CREATE TABLE asteroid (
    asteroid_id SERIAL PRIMARY KEY,  -- Cheie primară conform convenției
    name VARCHAR(50) UNIQUE NOT NULL,  -- Coloana unică
    size NUMERIC(10,2) NOT NULL CHECK (size > 0),  -- Dimensiunea asteroidului
    distance_from_planet NUMERIC(12,2) NOT NULL CHECK (distance_from_planet >= 0),  -- Distanța de la planetă
    planet_id INT NOT NULL,  -- Cheie străină care referă la planet
    FOREIGN KEY (planet_id) REFERENCES planet(planet_id)  -- Cheie străină care respectă convenția
);


INSERT INTO galaxy (name, galaxy_type, galaxy_diameter, star_numbers, description) VALUES 
('Calea Lactee (Milky Way)', 'spirala', 100000, 400000000000, 'Este galaxia noastră, un sistem spiral cu un diametru de aproximativ 100.000 de ani-lumină. Conține între 100 și 400 de miliarde de stele, printre care și Soarele, și găzduiește Sistemul Solar.'),
('Andromeda (M31)', 'spirala', '220000', 1000000000000, 'Cea mai apropiată galaxie spirală mare de Calea Lactee, situată la aproximativ 2,537 milioane de ani-lumină distanță. Este mai mare decât Calea Lactee și se îndreaptă spre coliziunea cu galaxia noastră într-un viitor îndepărtat.'),
('Galaxia Triangulum (M33)', 'spirala', 60000, 40000000000, 'Este a treia cea mai mare galaxie din Grupul Local, după Calea Lactee și Andromeda. Situată la aproximativ 3 milioane de ani-lumină, este o galaxie spirală de dimensiuni medii.'),
('Galaxia Sombrero (M104)', 'spirala', 10000, 800000000000,  'Este a treia cea mai mare galaxie din Grupul Local, după Calea Lactee și Andromeda. Situată la aproximativ 3 milioane de ani-lumină, este o galaxie spirală de dimensiuni medii.'),
('Galaxia Whirlpool (M51)', 'spirala', 76000, 1600000000000, 'Este o galaxie spirală situată la aproximativ 23 milioane de ani-lumină, cunoscută pentru structura sa clar definită și interacțiunea cu o galaxie satelit mai mică.'),
('Galaxia M82 (Cigar Galaxy)', 'neregulata', 37000, 300000000000, 'Situată la aproximativ 12 milioane de ani-lumină, această galaxie este cunoscută pentru activitatea sa intensă de formare a stelelor și pentru structura sa alungită.');

INSERT INTO star (name, spectral_type, star_size, luminosity, is_sun, galaxy_id ) VALUES 
('Soarele', 'G2V', 1, 1, True, 1),
('Alpha Centauri A', 'G2V', 1.1, 1519, True, 1),
('Betelgeuse', 'M1-2 Ia-ab', 20, 100000, False, 1), 
('NGC 206', 'O si B', 50, 1000000, False, 2),
('Mayall II (Cluster globular)', 'G si K', 1.2, 1.5, False, 2),
('LGS 3', 'M5III', 2, 2000, False, 3),
('Clusterul globular C39', 'F si K', 2, 2, False, 3),
('Clusterul globular G1', 'G si K', 1.2, 1.5, False, 4),
('Regiuni H II ', 'O si B', 50, 1000000, False, 4);


INSERT INTO planet (name, sun_distance, diameter, probability_of_life, star_id) VALUES ('Earth', 1.00, 12742, TRUE, 1), -- Soarele
('Mars', 1.52, 6779, FALSE, 1), -- Soarele
('Jupiter', 5.20, 139820, FALSE, 1), -- Soarele
('Proxima Centauri b', 0.05, 11600, TRUE, 2), -- Proxima Centauri
('Alpha Centauri Bb', 0.04, 11600, TRUE, 2), -- Alpha Centauri A
('Betelgeuse b', 3.00, 50000, FALSE, 3), -- Betelgeuse
('Betelgeuse c', 5.00, 70000, FALSE, 3), -- Betelgeuse
('Mayall II a', 10.00, 20000, FALSE, 4), -- Mayall II
('Mayall II b', 20.00, 30000, FALSE, 4), -- Mayall II
('LGS 3 b', 5.00, 25000, FALSE, 4), -- LGS 3
('R Doradus b', 3.00, 20000, FALSE, 5), -- R Doradus
('30 Doradus b', 10.00, 30000, FALSE, 7); -- 30 Doradus

INSERT INTO moon (name, planet_distance, unit_distance, diameter, unit_diameter, planet_id) VALUES 
('Moon', 384400, 'km', 3474, 'km', 1), -- Pământ
('Phobos', 6000, 'km', 22, 'km', 2), -- Marte
('Deimos', 23460, 'km', 12, 'km', 2), -- Marte
('Europa', 670900, 'km', 3122, 'km', 3), -- Jupiter
('Ganymede', 1070400, 'km', 5262, 'km', 3), -- Jupiter
('Callisto', 1882700, 'km', 4821, 'km', 3), -- Jupiter
('Io', 421700, 'km', 3643, 'km', 3), -- Jupiter
('Proxima Centauri b Moon 1', 50000, 'km', 1000, 'km', 4), -- Proxima Centauri b
('Alpha Centauri Bb Moon 1', 40000, 'km', 800, 'km', 5), -- Alpha Centauri Bb
('Betelgeuse b Moon 1', 80000, 'km', 2000, 'km', 6), -- Betelgeuse b
('Betelgeuse b Moon 2', 120000, 'km', 3000, 'km', 6), -- Betelgeuse b
('Betelgeuse c Moon 1', 100000, 'km', 2500, 'km', 7), -- Betelgeuse c
('Mayall II a Moon 1', 150000, 'km', 3500, 'km', 8), -- Mayall II a
('Mayall II b Moon 1', 200000, 'km', 4000, 'km', 9), -- Mayall II b
('LGS 3 b Moon 1', 100000, 'km', 1500, 'km', 10), -- LGS 3 b
('R Doradus b Moon 1', 70000, 'km', 2000, 'km', 11), -- R Doradus b
('30 Doradus b Moon 1', 120000, 'km', 2500, 'km', 12), -- 30 Doradus b
('30 Doradus b Moon 2', 180000, 'km', 2800, 'km', 12), -- 30 Doradus b
('30 Doradus b Moon 3', 220000, 'km', 3000, 'km', 12), -- 30 Doradus b
('30 Doradus b Moon 4', 260000, 'km', 3500, 'km', 12); -- 30 Doradus b


INSERT INTO asteroid (name, size, distance_from_planet, planet_id) VALUES 
('Ceres', 940.00, 413.00, 1),  -- planet_id=1 trebuie să existe în tabelul planet
('Vesta', 525.00, 107.00, 2),  -- planet_id=2 trebuie să existe în tabelul planet
('Pallas', 512.00, 152.00, 3),  -- planet_id=3 trebuie să existe în tabelul planet
('Juno', 234.00, 299.00, 4);  -- planet_id=4 trebuie să existe în tabelul planet
