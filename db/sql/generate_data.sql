USE [Avantvia Mission Control Database];
GO

EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO

DELETE FROM astronaut_missions;
DELETE FROM contract_manifest_links;
DELETE FROM payload_mission_manifests;
DELETE FROM stage_landing_target_links;
DELETE FROM mission_rocket_stages;
DELETE FROM missions;
DELETE FROM payloads;
DELETE FROM rocket_stages;
DELETE FROM contracts;
DELETE FROM astronauts;
DELETE FROM landing_targets;
DELETE FROM launch_pads;
DELETE FROM launch_sites;
DELETE FROM target_orbits;
DELETE FROM status_category_links;
DELETE FROM status_categories;
DELETE FROM status_codes;
DELETE FROM partner_organizations;
GO

DBCC CHECKIDENT ('astronaut_missions', RESEED, 0);
DBCC CHECKIDENT ('payload_mission_manifests', RESEED, 0);
DBCC CHECKIDENT ('missions', RESEED, 0);
DBCC CHECKIDENT ('payloads', RESEED, 0);
DBCC CHECKIDENT ('rocket_stages', RESEED, 0);
DBCC CHECKIDENT ('contracts', RESEED, 0);
DBCC CHECKIDENT ('astronauts', RESEED, 0);
DBCC CHECKIDENT ('landing_targets', RESEED, 0);
DBCC CHECKIDENT ('launch_pads', RESEED, 0);
DBCC CHECKIDENT ('launch_sites', RESEED, 0);
DBCC CHECKIDENT ('target_orbits', RESEED, 0);
DBCC CHECKIDENT ('partner_organizations', RESEED, 0);
GO

-- 1. Status Categories
INSERT INTO status_categories (category_code, category_name) VALUES 
(1, 'Mission'), (2, 'Deployment'), (3, 'Rocket Stage'), (4, 'Landing Target'), (5, 'Launch Pad'), (6, 'Payload'), (7, 'Astronaut');

-- 2. Status Codes
INSERT INTO status_codes (status_code, status_name) VALUES 
(1, 'Ready'), (2, 'Success'), (3, 'Failure'), (4, 'Partial Failure'), (5, 'Awaiting'), (6, 'On Hold'), (7, 'To Be Determined'), (8, 'Under Planning'), (9, 'Nominal'), (10, 'Degraded'), (11, 'Anomaly'), (12, 'Critical'), (13, 'Under Analysis'), (14, 'Cancelled'), (15, 'Propellant Loading'), (16, 'Weather Go'), (17, 'Weather Nogo'), (18, 'Weather Watch'), (19, 'Scrub'), (20, 'Signal Blackout'), (21, 'Signal Lost'), (22, 'Under Construction'), (23, 'Under Maintenance'), (24, 'On Route'), (25, 'On Mission'), (26, 'In Flight'), (27, 'Retired'), (28, 'Destroyed'), (29, 'Testing'), (30, 'Expended'), (31, 'Under Integration'), (32, 'Integrated'), (33, 'Occupied'), (34, 'Pad Hot'), (35, 'Pad Clear'), (36, 'Range Clear'), (37, 'On Station'), (38, 'Training'), (39, 'Recovering'), (40, 'Unavailable');

-- 3. Status Category Links
INSERT INTO status_category_links (category_code, status_code) VALUES 
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (1, 6), (1, 7), (1, 8), (1, 9), (1, 10), (1, 11), (1, 12), (1, 13), (1, 14), (1, 15), (1, 16), (1, 17), (1, 18), (1, 19), (1, 20), (1, 21),
(2, 1), (2, 2), (2, 3), (2, 5), (2, 6), (2, 11),
(3, 22), (3, 23), (3, 24), (3, 1), (3, 25), (3, 26), (3, 27), (3, 28), (3, 29), (3, 9), (3, 10), (3, 11), (3, 12), (3, 30), (3, 31), (3, 32),
(4, 22), (4, 23), (4, 24), (4, 1), (4, 25), (4, 9), (4, 10), (4, 11), (4, 12), (4, 16), (4, 17), (4, 18),
(5, 22), (5, 23), (5, 1), (5, 33), (5, 11), (5, 34), (5, 35), (5, 36),
(6, 22), (6, 23), (6, 24), (6, 1), (6, 29), (6, 28), (6, 27), (6, 25), (6, 9), (6, 10), (6, 11), (6, 12), (6, 13), (6, 37), (6, 5),
(7, 27), (7, 38), (7, 25), (7, 39), (7, 11), (7, 40), (7, 1); -- Included 1 for Ready

-- 4. Partner Organizations
SET IDENTITY_INSERT partner_organizations ON;
INSERT INTO partner_organizations (partner_id, partner_name, partner_type, partner_country_of_origin, partner_notes) VALUES
(1, 'Avantvia', 'Company', 'USA', 'Internal'), 
(2, 'NASA', 'Agency', 'USA', 'NASA'), 
(3, 'ESA', 'Agency', 'Europe', 'ESA'), 
(4, 'JAXA', 'Agency', 'Japan', 'JAXA'), 
(5, 'OrbitNet', 'Company', 'USA', 'Sat Internet'), 
(6, 'MIT', 'University', 'USA', 'MIT'), 
(7, 'Stanford', 'University', 'USA', 'Stanford'), 
(8, 'Oxford', 'University', 'UK', 'Oxford'), 
(9, 'Caltech', 'University', 'USA', 'Caltech'), 
(10, 'University of Tokyo', 'University', 'Japan', 'UTokyo'), 
(11, 'Max Planck Institute', 'Institute', 'Germany', 'Max Planck');
SET IDENTITY_INSERT partner_organizations OFF;

-- 5. Launch Sites & Pads
SET IDENTITY_INSERT launch_sites ON;
INSERT INTO launch_sites (launch_site_id, launch_site_name, launch_site_country) VALUES (1, 'Cape Orizon', 'USA'), (2, 'Vandenberg SFB', 'USA'), (3, 'Guiana Space Centre', 'French Guiana');
SET IDENTITY_INSERT launch_sites OFF;

SET IDENTITY_INSERT launch_pads ON;
INSERT INTO launch_pads (launch_pad_id, launch_site_id, launch_pad_name, launch_pad_longitude, launch_pad_latitude, launch_pad_status_code) VALUES 
(1, 1, 'Pad A', -80.5, 28.5, 1), (2, 1, 'Pad B', -80.6, 28.5, 1), (3, 1, 'Pad C', -80.5, 28.6, 1), 
(4, 2, 'Pad D', -120.6, 34.6, 1), (5, 3, 'Pad E', -52.6, 5.2, 1);
SET IDENTITY_INSERT launch_pads OFF;

-- 6. Landing Targets
SET IDENTITY_INSERT landing_targets ON;
INSERT INTO landing_targets (landing_target_id, landing_target_name, landing_target_site, landing_target_type, landing_target_status_code) VALUES 
(1, 'Ad Astra', 'Atlantic Ocean', 'ASDS', 1), (2, 'Per Aspera', 'Atlantic Ocean', 'ASDS', 1), 
(3, 'Audentes', 'Pacific Ocean', 'ASDS', 1), (4, 'Ground Pad 1', 'Cape Orizon', 'Ground Pad', 1), 
(5, 'Ground Pad 2', 'Cape Orizon', 'Ground Pad', 1), (6, 'Ground Pad 3', 'Vandenberg SFB', 'Ground Pad', 1);
SET IDENTITY_INSERT landing_targets OFF;

-- 7. Target Orbits
SET IDENTITY_INSERT target_orbits ON;
INSERT INTO target_orbits (target_orbit_id, orbit_name, apoapsis_cm, periapsis_cm, inclination_deg, is_interplanetary, target_body, orbit_notes) VALUES 
(1, 'LEO', 20000000, 20000000, 51.6, 0, 'Earth', 'LEO'), 
(2, 'ISS', 40000000, 40000000, 51.6, 0, 'Earth', 'ISS'), 
(3, 'SSO', 50000000, 50000000, 97.4, 0, 'Earth', 'SSO'), 
(4, 'GTO', 3500000000, 20000000, 28.5, 0, 'Earth', 'GTO'), 
(5, 'GEO', 3500000000, 3500000000, 0.0, 0, 'Earth', 'GEO'), 
(6, 'TLI', 38440000000, 20000000, 28.5, 1, 'Moon', 'Moon'), 
(7, 'MTO', 22500000000000, 20000000, 0.0, 1, 'Mars', 'Mars');
SET IDENTITY_INSERT target_orbits OFF;

-- 8. Astronauts
SET IDENTITY_INSERT astronauts ON;
INSERT INTO astronauts (astronaut_id, first_name, last_name, date_of_birth, nationality, agency_id, astronaut_status_code) VALUES 
(1, 'Sarah', 'Kerrigan', '1985-05-12', 'USA', 2, 25), 
(2, 'Marcus', 'Aurelius', '1982-10-04', 'Italy', 3, 25), 
(3, 'Hiroshi', 'Tanaka', '1990-01-22', 'Japan', 4, 25), 
(4, 'Elena', 'Rostova', '1988-08-15', 'USA', 1, 25), 
(5, 'James', 'Holden', '1975-03-30', 'USA', 2, 1), 
(6, 'Naomi', 'Nagata', '1992-11-11', 'UK', 3, 1), 
(7, 'Amos', 'Burton', '1980-07-07', 'USA', 1, 1), 
(8, 'Alex', 'Kamal', '1984-02-14', 'USA', 2, 27), 
(9, 'Chrisjen', 'Avasarala', '1965-09-09', 'India', 1, 27), 
(10, 'Bobbie', 'Draper', '1989-12-25', 'New Zealand', 3, 39), 
(11, 'Joe', 'Miller', '1985-01-10', 'USA', 2, 1);
SET IDENTITY_INSERT astronauts OFF;

-- 9. Rocket Stages
SET IDENTITY_INSERT rocket_stages ON;
INSERT INTO rocket_stages (stage_id, stage_type, stage_serial, stage_status_code) VALUES 
(1, 'Excelsior 2 Stage 1', 'EXC23-11001', 1), -- The Legend
(2, 'Excelsior 2 Stage 1', 'EXC23-11002', 1), 
(3, 'Excelsior 2 Stage 1', 'EXC23-11003', 1),
(4, 'Excelsior 2 Stage 1', 'EXC23-11004', 1),
(5, 'Excelsior 2 Stage 1', 'EXC23-11005', 1),
(6, 'Excelsior 1 Stage 1', 'EXC11-10001', 27),
(7, 'Excelsior 1 Stage 1', 'EXC11-10002', 28),
(8, 'Excelsior 1 Stage 1', 'EXC11-10003', 30),
(9, 'Excelsior 1 Stage 2', 'EXC11-20001', 30),
(10, 'Excelsior Nova Stage 1', 'EXCN1-10001', 28),
(11, 'Excelsior Nova Stage 2', 'EXCN1-20001', 28),
(12, 'Excelsior Nova Stage 1', 'EXCN1-10002', 1),
(13, 'Excelsior Nova Stage 2', 'EXCN1-20002', 1);
SET IDENTITY_INSERT rocket_stages OFF;

BEGIN TRANSACTION;
BEGIN TRY
DECLARE @MissionID INT, @PayloadID INT, @ManifestID INT, @ContractID INT, @StageLinkID INT;

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Commercial Delivery 1', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Orion 1', 2, 0, DATEADD(MONTH, 2, '2020-01-01'), DATEADD(MONTH, 2, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-1', 'EarthObs 1', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21001', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 2);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Scientific 2', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Helios 2', 3, 0, DATEADD(MONTH, 4, '2020-01-01'), DATEADD(MONTH, 4, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-2', 'Recon 2', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21002', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 3);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Broadband Expansion 3', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nyx 3', 1, 0, DATEADD(MONTH, 6, '2020-01-01'), DATEADD(MONTH, 6, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-3', 'EarthObs 3', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21003', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 4);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Gov Ops 4', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Vanguard 4', 2, 0, DATEADD(MONTH, 8, '2020-01-01'), DATEADD(MONTH, 8, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-4', 'Weather 4', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21004', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 5);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Scientific 5', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zenith 5', 3, 0, DATEADD(MONTH, 10, '2020-01-01'), DATEADD(MONTH, 10, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-5', 'EarthObs 5', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21005', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Broadband Expansion 6', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Odin 6', 1, 0, DATEADD(MONTH, 12, '2020-01-01'), DATEADD(MONTH, 12, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-6', 'Recon 6', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21006', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 2);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Global Network 7', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Polaris 7', 2, 0, DATEADD(MONTH, 14, '2020-01-01'), DATEADD(MONTH, 14, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-7', 'EarthObs 7', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21007', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 3);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Global Network 8', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Sirius 8', 3, 0, DATEADD(MONTH, 16, '2020-01-01'), DATEADD(MONTH, 16, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-8', 'NavSat 8', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21008', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 4);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Gov Ops 9', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer 9', 1, 0, DATEADD(MONTH, 18, '2020-01-01'), DATEADD(MONTH, 18, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-9', 'NavSat 9', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21009', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 5);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Gov Ops 10', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Sirius 10', 2, 0, DATEADD(MONTH, 20, '2020-01-01'), DATEADD(MONTH, 20, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-10', 'Recon 10', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21010', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Commercial Delivery 11', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zeus 11', 3, 0, DATEADD(MONTH, 22, '2020-01-01'), DATEADD(MONTH, 22, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-11', 'Recon 11', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21011', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 2);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Scientific 12', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer 12', 1, 0, DATEADD(MONTH, 24, '2020-01-01'), DATEADD(MONTH, 24, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-12', 'Weather 12', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21012', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 3);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Global Network 13', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zeus 13', 2, 0, DATEADD(MONTH, 26, '2020-01-01'), DATEADD(MONTH, 26, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-13', 'NavSat 13', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21013', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 4);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Scientific 14', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Apex 14', 3, 0, DATEADD(MONTH, 28, '2020-01-01'), DATEADD(MONTH, 28, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-14', 'Commsat 14', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21014', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 5);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Broadband Expansion 15', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Apex 15', 1, 0, DATEADD(MONTH, 30, '2020-01-01'), DATEADD(MONTH, 30, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-15', 'Recon 15', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21015', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Gov Ops 16', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Chronos 16', 2, 0, DATEADD(MONTH, 32, '2020-01-01'), DATEADD(MONTH, 32, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-16', 'Weather 16', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21016', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 2);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Broadband Expansion 17', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer 17', 3, 0, DATEADD(MONTH, 34, '2020-01-01'), DATEADD(MONTH, 34, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-17', 'Relay 17', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21017', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 3);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Scientific 18', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Titan 18', 1, 0, DATEADD(MONTH, 36, '2020-01-01'), DATEADD(MONTH, 36, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-18', 'Commsat 18', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21018', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 4);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Gov Ops 19', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Vanguard 19', 2, 0, DATEADD(MONTH, 38, '2020-01-01'), DATEADD(MONTH, 38, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-19', 'NavSat 19', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21019', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 5);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Global Network 20', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer 20', 3, 0, DATEADD(MONTH, 40, '2020-01-01'), DATEADD(MONTH, 40, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-20', 'Weather 20', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21020', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Commercial Delivery 21', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Titan 21', 1, 0, DATEADD(MONTH, 42, '2020-01-01'), DATEADD(MONTH, 42, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-21', 'Weather 21', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21021', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 2);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Global Network 22', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Sirius 22', 2, 0, DATEADD(MONTH, 44, '2020-01-01'), DATEADD(MONTH, 44, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-22', 'EarthObs 22', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21022', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 3);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Scientific 23', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zenith 23', 3, 0, DATEADD(MONTH, 46, '2020-01-01'), DATEADD(MONTH, 46, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-23', 'NavSat 23', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21023', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 4);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Broadband Expansion 24', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zenith 24', 1, 0, DATEADD(MONTH, 48, '2020-01-01'), DATEADD(MONTH, 48, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-24', 'NavSat 24', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21024', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 5);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Avantvia Commercial Delivery 25', '2020-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Odin 25', 2, 0, DATEADD(MONTH, 50, '2020-01-01'), DATEADD(MONTH, 50, '2020-01-01'), 2, 'Legendary', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('LEG-25', 'Weather 25', 'Satellite', 2500000, 1, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-21025', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 1, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Commercial Delivery 1', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate1 DATETIME = DATEADD(DAY, -(1 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Apex Block B-1', CASE WHEN 1 % 5 = 0 THEN 4 ELSE (1 % 3) + 1 END, 0, @CadenceDate1, @CadenceDate1, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-1', 'EarthObs 101', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22001', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 1 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Broadband Expansion 2', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate2 DATETIME = DATEADD(DAY, -(2 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Hermes Block B-2', CASE WHEN 2 % 5 = 0 THEN 4 ELSE (2 % 3) + 1 END, 0, @CadenceDate2, @CadenceDate2, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-2', 'Recon 102', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22002', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 2 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Gov Ops 3', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate3 DATETIME = DATEADD(DAY, -(3 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Chronos Block B-3', CASE WHEN 3 % 5 = 0 THEN 4 ELSE (3 % 3) + 1 END, 0, @CadenceDate3, @CadenceDate3, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-3', 'NavSat 103', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22003', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 3 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Commercial Delivery 4', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate4 DATETIME = DATEADD(DAY, -(4 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Horizon Block B-4', CASE WHEN 4 % 5 = 0 THEN 4 ELSE (4 % 3) + 1 END, 0, @CadenceDate4, @CadenceDate4, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-4', 'Relay 104', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22004', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 4 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Commercial Delivery 5', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate5 DATETIME = DATEADD(DAY, -(5 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Helios Block B-5', CASE WHEN 5 % 5 = 0 THEN 4 ELSE (5 % 3) + 1 END, 0, @CadenceDate5, @CadenceDate5, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-5', 'EarthObs 105', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22005', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 5 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Broadband Expansion 6', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate6 DATETIME = DATEADD(DAY, -(6 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Chronos Block B-6', CASE WHEN 6 % 5 = 0 THEN 4 ELSE (6 % 3) + 1 END, 0, @CadenceDate6, @CadenceDate6, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-6', 'EarthObs 106', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22006', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 6 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Gov Ops 7', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate7 DATETIME = DATEADD(DAY, -(7 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Horizon Block B-7', CASE WHEN 7 % 5 = 0 THEN 4 ELSE (7 % 3) + 1 END, 0, @CadenceDate7, @CadenceDate7, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-7', 'Recon 107', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22007', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 7 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Broadband Expansion 8', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate8 DATETIME = DATEADD(DAY, -(8 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Vega Block B-8', CASE WHEN 8 % 5 = 0 THEN 4 ELSE (8 % 3) + 1 END, 0, @CadenceDate8, @CadenceDate8, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-8', 'Weather 108', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22008', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 8 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Scientific 9', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate9 DATETIME = DATEADD(DAY, -(9 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Apollo Block B-9', CASE WHEN 9 % 5 = 0 THEN 4 ELSE (9 % 3) + 1 END, 0, @CadenceDate9, @CadenceDate9, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-9', 'NavSat 109', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22009', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 9 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Global Network 10', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate10 DATETIME = DATEADD(DAY, -(10 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Titan Block B-10', CASE WHEN 10 % 5 = 0 THEN 4 ELSE (10 % 3) + 1 END, 0, @CadenceDate10, @CadenceDate10, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-10', 'NavSat 110', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22010', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 10 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Commercial Delivery 11', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate11 DATETIME = DATEADD(DAY, -(11 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Vanguard Block B-11', CASE WHEN 11 % 5 = 0 THEN 4 ELSE (11 % 3) + 1 END, 0, @CadenceDate11, @CadenceDate11, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-11', 'Commsat 111', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22011', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 11 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Global Network 12', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate12 DATETIME = DATEADD(DAY, -(12 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nyx Block B-12', CASE WHEN 12 % 5 = 0 THEN 4 ELSE (12 % 3) + 1 END, 0, @CadenceDate12, @CadenceDate12, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-12', 'NavSat 112', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22012', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 12 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Gov Ops 13', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate13 DATETIME = DATEADD(DAY, -(13 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Sirius Block B-13', CASE WHEN 13 % 5 = 0 THEN 4 ELSE (13 % 3) + 1 END, 0, @CadenceDate13, @CadenceDate13, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-13', 'NavSat 113', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22013', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 13 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Scientific 14', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate14 DATETIME = DATEADD(DAY, -(14 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer Block B-14', CASE WHEN 14 % 5 = 0 THEN 4 ELSE (14 % 3) + 1 END, 0, @CadenceDate14, @CadenceDate14, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-14', 'Recon 114', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22014', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 14 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Broadband Expansion 15', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate15 DATETIME = DATEADD(DAY, -(15 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer Block B-15', CASE WHEN 15 % 5 = 0 THEN 4 ELSE (15 % 3) + 1 END, 0, @CadenceDate15, @CadenceDate15, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-15', 'NavSat 115', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22015', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 15 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Commercial Delivery 16', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate16 DATETIME = DATEADD(DAY, -(16 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Apollo Block B-16', CASE WHEN 16 % 5 = 0 THEN 4 ELSE (16 % 3) + 1 END, 0, @CadenceDate16, @CadenceDate16, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-16', 'Recon 116', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22016', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 16 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Gov Ops 17', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate17 DATETIME = DATEADD(DAY, -(17 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Orion Block B-17', CASE WHEN 17 % 5 = 0 THEN 4 ELSE (17 % 3) + 1 END, 0, @CadenceDate17, @CadenceDate17, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-17', 'EarthObs 117', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22017', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 17 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Gov Ops 18', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate18 DATETIME = DATEADD(DAY, -(18 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Apex Block B-18', CASE WHEN 18 % 5 = 0 THEN 4 ELSE (18 % 3) + 1 END, 0, @CadenceDate18, @CadenceDate18, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-18', 'EarthObs 118', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22018', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 18 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Global Network 19', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate19 DATETIME = DATEADD(DAY, -(19 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zenith Block B-19', CASE WHEN 19 % 5 = 0 THEN 4 ELSE (19 % 3) + 1 END, 0, @CadenceDate19, @CadenceDate19, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-19', 'Weather 119', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22019', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 19 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (5, 'Global Gov Ops 20', '2024-01-01', 20000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
DECLARE @CadenceDate20 DATETIME = DATEADD(DAY, -(20 * 15), GETDATE());
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Orion Block B-20', CASE WHEN 20 % 5 = 0 THEN 4 ELSE (20 % 3) + 1 END, 0, @CadenceDate20, @CadenceDate20, 2, 'Cadence', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CAD-20', 'Relay 120', 'Satellite', 100000, 5, 5, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-22020', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, CASE WHEN 20 % 2 = 0 THEN 2 ELSE 3 END, 1, 'Stage 1');
SET @StageLinkID = SCOPE_IDENTITY();
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (@StageLinkID, 1);

-- NASA 1
INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (2, 'NASA Earth Sciences 2024', '2023-01-01', 400000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('NASA Landsat 10', 1, 0, '2024-06-15 10:00:00', '2024-06-15 10:00:00', 2, 'Earth Obs', 'Success');
SET @MissionID = SCOPE_IDENTITY();
-- MFR is Avantvia, Customer is NASA
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('L-10', 'Landsat 10', 'Satellite', 2000000, 1, 2, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-23001', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 2, 1, 'Stage 1');
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (SCOPE_IDENTITY(), 4);

-- NASA 2
INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (2, 'NASA Deep Space Probes', '2023-05-01', 750000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('NASA Deep Space 1', 2, 0, '2024-10-10 10:00:00', '2024-10-10 10:00:00', 2, 'Deep space', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('DS-1', 'Deep Space Climate Obs', 'Satellite', 3000000, 1, 2, 37);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 6, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-23002', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 3, 1, 'Stage 1');
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (SCOPE_IDENTITY(), 1);

-- NASA 3 (Crew-7)
INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (2, 'NASA CCtCap 2', '2023-08-01', 1200000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('NASA Crew-7', 1, 1, '2025-02-15 10:00:00', '2025-02-15 10:00:00', 2, 'Crew rot', 'Success');
SET @MissionID = SCOPE_IDENTITY();
-- Avantvia owns capsule (1), Avantvia manufactured it (1). NASA contract above covers launch
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('V-CR-7', 'Viator Crew Capsule 7', 'Capsule', 12500000, 1, 1, 37); 
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 2, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-23003', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 2, 1, 'Stage 1');
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (SCOPE_IDENTITY(), 4);
INSERT INTO astronaut_missions (mission_id, astronaut_id, astronaut_role, is_backup) VALUES (@MissionID, 5, 'Commander', 0), (@MissionID, 6, 'Pilot', 0);

-- ONGOING CREW MISSION (Crew-8)
INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (2, 'NASA Commercial Crew 2026', '2024-01-01', 1200000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
-- mission_status_code = 9 (Nominal)
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('NASA Crew-8', 1, 1, GETDATE(), GETDATE(), 9, 'Active ISS rotation', NULL); 
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('V-CR-8', 'Viator Crew Capsule 8', 'Capsule', 12500000, 1, 1, 9);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 2, 9);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-24001', 26);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 3, 1, 'Stage 1');
INSERT INTO astronaut_missions (mission_id, astronaut_id, astronaut_role, is_backup) VALUES (@MissionID, 1, 'Commander', 0), (@MissionID, 2, 'Pilot', 0), (@MissionID, 3, 'Mission Specialist', 0);

-- Extra Crew Missions
INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (2, 'NASA CCtCap 1', '2018-09-16', 2600000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();

INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('NASA Crew-5', 1, 1, '2023-05-10 10:00:00', '2023-05-10 10:00:00', 2, 'Crew rot', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('V-CR-5', 'Viator Crew Capsule 5', 'Capsule', 12500000, 1, 1, 37); 
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 2, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-24005', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 2, 1, 'Stage 1');
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (SCOPE_IDENTITY(), 4);
INSERT INTO astronaut_missions (mission_id, astronaut_id, astronaut_role, is_backup) VALUES (@MissionID, 5, 'Commander', 0), (@MissionID, 6, 'Pilot', 0);

INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('NASA Crew-6', 1, 1, '2024-03-01 10:00:00', '2024-03-01 10:00:00', 2, 'Crew rot', 'Success');
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('V-CR-6', 'Viator Crew Capsule 6', 'Capsule', 12500000, 1, 1, 37); 
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 2, 2);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-24006', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 2, 1, 'Stage 1');
INSERT INTO stage_landing_target_links (mission_stage_id, landing_target_id) VALUES (SCOPE_IDENTITY(), 4);
INSERT INTO astronaut_missions (mission_id, astronaut_id, astronaut_role, is_backup) VALUES (@MissionID, 1, 'Commander', 0), (@MissionID, 2, 'Pilot', 0);


-- Cosmic-Share 7 (11 payloads)
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Cosmic-Share 7', 4, 0, '2026-11-15 14:00:00', '2026-11-15 14:00:00', 8, 'Mega Rideshare 1', NULL);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-25001', 1);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 2, 1, 'Stage 1');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((7), 'University Rideshare Nyx 1', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-1', 'Student Nyx 1', 'CubeSat', 5000, 6, (7), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((8), 'University Rideshare Helios 2', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-2', 'Research Odin 2', 'CubeSat', 5000, 6, (8), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((9), 'University Rideshare Polaris 3', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-3', 'Tech Chronos 3', 'CubeSat', 5000, 6, (9), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((10), 'University Rideshare Nova 4', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-4', 'Academic Horizon 4', 'CubeSat', 5000, 6, (10), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((11), 'University Rideshare Ares 5', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-5', 'Student Zeus 5', 'CubeSat', 5000, 6, (11), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((6), 'University Rideshare Zeus 6', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-6', 'Tech Sol 6', 'CubeSat', 5000, 6, (6), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((7), 'University Rideshare Hermes 7', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-7', 'Tech Horizon 7', 'CubeSat', 5000, 6, (7), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((8), 'University Rideshare Titan 8', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-8', 'Student Vanguard 8', 'CubeSat', 5000, 6, (8), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((9), 'University Rideshare Luna 9', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-9', 'Academic Apex 9', 'CubeSat', 5000, 6, (9), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((10), 'University Rideshare Titan 10', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-10', 'Research Polaris 10', 'CubeSat', 5000, 6, (10), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((11), 'University Rideshare Apex 11', '2025-01-01', 500000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS7-11', 'Research Vega 11', 'CubeSat', 5000, 6, (11), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

-- Cosmic-Share 8 (6 payloads)
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Cosmic-Share 8', 4, 0, '2027-02-15 14:00:00', '2027-02-15 14:00:00', 8, 'Mega Rideshare 2', NULL);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-25002', 1);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 3, 1, 'Stage 1');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((8), 'University Rideshare Zeus 12', '2025-02-01', 600000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS8-1', 'Research Sirius 12', 'CubeSat', 8000, 7, (8), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((9), 'University Rideshare Chronos 13', '2025-02-01', 600000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS8-2', 'Academic Ares 13', 'CubeSat', 8000, 7, (9), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((10), 'University Rideshare Pioneer 14', '2025-02-01', 600000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS8-3', 'Tech Argus 14', 'CubeSat', 8000, 7, (10), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((11), 'University Rideshare Zenith 15', '2025-02-01', 600000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS8-4', 'Tech Nova 15', 'CubeSat', 8000, 7, (11), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((7), 'University Rideshare Nova 16', '2025-02-01', 600000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS8-5', 'Academic Odin 16', 'CubeSat', 8000, 7, (7), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES ((8), 'University Rideshare Zenith 17', '2025-02-01', 600000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('CS8-6', 'Student Apex 17', 'CubeSat', 8000, 7, (8), 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 3, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Scientific 1', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Atlas Legacy-1', 1, 0, DATEADD(MONTH, 1, '2016-01-01'), DATEADD(MONTH, 1, '2016-01-01'), CASE WHEN 1 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 1 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P1', 'MicroSat Sirius 1', 'Satellite', 100000, 1, 1, CASE WHEN 1 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 1 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11001', CASE WHEN 1 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21001', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 2', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Chronos Legacy-2', 1, 0, DATEADD(MONTH, 2, '2016-01-01'), DATEADD(MONTH, 2, '2016-01-01'), CASE WHEN 2 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 2 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P2', 'MicroSat Apex 2', 'Satellite', 100000, 1, 1, CASE WHEN 2 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 2 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11002', CASE WHEN 2 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21002', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Gov Ops 3', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Luna Legacy-3', 1, 0, DATEADD(MONTH, 3, '2016-01-01'), DATEADD(MONTH, 3, '2016-01-01'), CASE WHEN 3 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 3 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P3', 'MicroSat Orion 3', 'Satellite', 100000, 1, 1, CASE WHEN 3 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 3 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11003', CASE WHEN 3 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21003', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Broadband Expansion 4', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Orion Legacy-4', 1, 0, DATEADD(MONTH, 4, '2016-01-01'), DATEADD(MONTH, 4, '2016-01-01'), CASE WHEN 4 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 4 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P4', 'MicroSat Apex 4', 'Satellite', 100000, 1, 1, CASE WHEN 4 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 4 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11004', CASE WHEN 4 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21004', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Broadband Expansion 5', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Ares Legacy-5', 1, 0, DATEADD(MONTH, 5, '2016-01-01'), DATEADD(MONTH, 5, '2016-01-01'), CASE WHEN 5 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 5 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P5', 'MicroSat Argus 5', 'Satellite', 100000, 1, 1, CASE WHEN 5 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 5 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11005', CASE WHEN 5 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21005', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 6', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nyx Legacy-6', 1, 0, DATEADD(MONTH, 6, '2016-01-01'), DATEADD(MONTH, 6, '2016-01-01'), CASE WHEN 6 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 6 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P6', 'MicroSat Hermes 6', 'Satellite', 100000, 1, 1, CASE WHEN 6 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 6 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11006', CASE WHEN 6 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21006', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 7', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Titan Legacy-7', 1, 0, DATEADD(MONTH, 7, '2016-01-01'), DATEADD(MONTH, 7, '2016-01-01'), CASE WHEN 7 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 7 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P7', 'MicroSat Helios 7', 'Satellite', 100000, 1, 1, CASE WHEN 7 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 7 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11007', CASE WHEN 7 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21007', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Broadband Expansion 8', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zeus Legacy-8', 1, 0, DATEADD(MONTH, 8, '2016-01-01'), DATEADD(MONTH, 8, '2016-01-01'), CASE WHEN 8 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 8 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P8', 'MicroSat Polaris 8', 'Satellite', 100000, 1, 1, CASE WHEN 8 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 8 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11008', CASE WHEN 8 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21008', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Gov Ops 9', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Vanguard Legacy-9', 1, 0, DATEADD(MONTH, 9, '2016-01-01'), DATEADD(MONTH, 9, '2016-01-01'), CASE WHEN 9 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 9 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P9', 'MicroSat Hermes 9', 'Satellite', 100000, 1, 1, CASE WHEN 9 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 9 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11009', CASE WHEN 9 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21009', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 10', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Echo Legacy-10', 1, 0, DATEADD(MONTH, 10, '2016-01-01'), DATEADD(MONTH, 10, '2016-01-01'), CASE WHEN 10 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 10 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P10', 'MicroSat Sol 10', 'Satellite', 100000, 1, 1, CASE WHEN 10 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 10 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11010', CASE WHEN 10 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21010', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 11', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Vega Legacy-11', 1, 0, DATEADD(MONTH, 11, '2016-01-01'), DATEADD(MONTH, 11, '2016-01-01'), CASE WHEN 11 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 11 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P11', 'MicroSat Atlas 11', 'Satellite', 100000, 1, 1, CASE WHEN 11 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 11 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11011', CASE WHEN 11 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21011', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 12', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Hermes Legacy-12', 1, 0, DATEADD(MONTH, 12, '2016-01-01'), DATEADD(MONTH, 12, '2016-01-01'), CASE WHEN 12 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 12 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P12', 'MicroSat Nyx 12', 'Satellite', 100000, 1, 1, CASE WHEN 12 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 12 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11012', CASE WHEN 12 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21012', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 13', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Polaris Legacy-13', 1, 0, DATEADD(MONTH, 13, '2016-01-01'), DATEADD(MONTH, 13, '2016-01-01'), CASE WHEN 13 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 13 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P13', 'MicroSat Sirius 13', 'Satellite', 100000, 1, 1, CASE WHEN 13 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 13 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11013', CASE WHEN 13 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21013', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 14', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zeus Legacy-14', 1, 0, DATEADD(MONTH, 14, '2016-01-01'), DATEADD(MONTH, 14, '2016-01-01'), CASE WHEN 14 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 14 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P14', 'MicroSat Sol 14', 'Satellite', 100000, 1, 1, CASE WHEN 14 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 14 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11014', CASE WHEN 14 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21014', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 15', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Luna Legacy-15', 1, 0, DATEADD(MONTH, 15, '2016-01-01'), DATEADD(MONTH, 15, '2016-01-01'), CASE WHEN 15 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 15 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P15', 'MicroSat Ares 15', 'Satellite', 100000, 1, 1, CASE WHEN 15 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 15 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11015', CASE WHEN 15 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21015', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 16', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Zeus Legacy-16', 1, 0, DATEADD(MONTH, 16, '2016-01-01'), DATEADD(MONTH, 16, '2016-01-01'), CASE WHEN 16 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 16 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P16', 'MicroSat Hermes 16', 'Satellite', 100000, 1, 1, CASE WHEN 16 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 16 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11016', CASE WHEN 16 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21016', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Commercial Delivery 17', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Ares Legacy-17', 1, 0, DATEADD(MONTH, 17, '2016-01-01'), DATEADD(MONTH, 17, '2016-01-01'), CASE WHEN 17 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 17 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P17', 'MicroSat Atlas 17', 'Satellite', 100000, 1, 1, CASE WHEN 17 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 17 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11017', CASE WHEN 17 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21017', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Gov Ops 18', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer Legacy-18', 1, 0, DATEADD(MONTH, 18, '2016-01-01'), DATEADD(MONTH, 18, '2016-01-01'), CASE WHEN 18 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 18 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P18', 'MicroSat Ares 18', 'Satellite', 100000, 1, 1, CASE WHEN 18 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 18 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11018', CASE WHEN 18 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21018', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 19', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Titan Legacy-19', 1, 0, DATEADD(MONTH, 19, '2016-01-01'), DATEADD(MONTH, 19, '2016-01-01'), CASE WHEN 19 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 19 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P19', 'MicroSat Sirius 19', 'Satellite', 100000, 1, 1, CASE WHEN 19 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 19 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11019', CASE WHEN 19 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21019', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 20', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Echo Legacy-20', 1, 0, DATEADD(MONTH, 20, '2016-01-01'), DATEADD(MONTH, 20, '2016-01-01'), CASE WHEN 20 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 20 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P20', 'MicroSat Sirius 20', 'Satellite', 100000, 1, 1, CASE WHEN 20 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 20 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11020', CASE WHEN 20 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21020', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 21', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Chronos Legacy-21', 1, 0, DATEADD(MONTH, 21, '2016-01-01'), DATEADD(MONTH, 21, '2016-01-01'), CASE WHEN 21 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 21 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P21', 'MicroSat Nyx 21', 'Satellite', 100000, 1, 1, CASE WHEN 21 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 21 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11021', CASE WHEN 21 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21021', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Scientific 22', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Legacy-22', 1, 0, DATEADD(MONTH, 22, '2016-01-01'), DATEADD(MONTH, 22, '2016-01-01'), CASE WHEN 22 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 22 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P22', 'MicroSat Orion 22', 'Satellite', 100000, 1, 1, CASE WHEN 22 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 22 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11022', CASE WHEN 22 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21022', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Legacy Global Network 23', '2015-01-01', 5000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Pioneer Legacy-23', 1, 0, DATEADD(MONTH, 23, '2016-01-01'), DATEADD(MONTH, 23, '2016-01-01'), CASE WHEN 23 % 4 = 0 THEN 3 ELSE 2 END, 'EXC1', CASE WHEN 23 % 4 = 0 THEN 'Failure' ELSE 'Success' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('EXC1-P23', 'MicroSat Nyx 23', 'Satellite', 100000, 1, 1, CASE WHEN 23 % 4 = 0 THEN 28 ELSE 37 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 23 % 4 = 0 THEN 3 ELSE 2 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 1', 'EXC11-11023', CASE WHEN 23 % 4 = 0 THEN 28 ELSE 30 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 1 Stage 2', 'EXC11-21023', 30);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 1', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 1', 5, 0, DATEADD(MONTH, 1, '2024-01-01'), DATEADD(MONTH, 1, '2024-01-01'), CASE WHEN 1 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 1 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P1', 'Nova Mass Sim 1', 'Test Mass', 50000000, 1, 1, CASE WHEN 1 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 1 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10008', CASE WHEN 1 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20008', CASE WHEN 1 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 2', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 2', 5, 0, DATEADD(MONTH, 2, '2024-01-01'), DATEADD(MONTH, 2, '2024-01-01'), CASE WHEN 2 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 2 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P2', 'Nova Mass Sim 2', 'Test Mass', 50000000, 1, 1, CASE WHEN 2 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 2 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10009', CASE WHEN 2 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20009', CASE WHEN 2 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 3', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 3', 5, 0, DATEADD(MONTH, 3, '2024-01-01'), DATEADD(MONTH, 3, '2024-01-01'), CASE WHEN 3 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 3 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P3', 'Nova Mass Sim 3', 'Test Mass', 50000000, 1, 1, CASE WHEN 3 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 3 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10003', CASE WHEN 3 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20003', CASE WHEN 3 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 4', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 4', 5, 0, DATEADD(MONTH, 4, '2024-01-01'), DATEADD(MONTH, 4, '2024-01-01'), CASE WHEN 4 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 4 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P4', 'Nova Mass Sim 4', 'Test Mass', 50000000, 1, 1, CASE WHEN 4 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 4 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10004', CASE WHEN 4 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20004', CASE WHEN 4 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 5', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 5', 5, 0, DATEADD(MONTH, 5, '2024-01-01'), DATEADD(MONTH, 5, '2024-01-01'), CASE WHEN 5 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 5 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P5', 'Nova Mass Sim 5', 'Test Mass', 50000000, 1, 1, CASE WHEN 5 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 5 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10005', CASE WHEN 5 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20005', CASE WHEN 5 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 6', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 6', 5, 0, DATEADD(MONTH, 6, '2024-01-01'), DATEADD(MONTH, 6, '2024-01-01'), CASE WHEN 6 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 6 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P6', 'Nova Mass Sim 6', 'Test Mass', 50000000, 1, 1, CASE WHEN 6 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 6 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10006', CASE WHEN 6 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20006', CASE WHEN 6 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (1, 'Avantvia Dev Contract 7', '2023-01-01', 50000000.00, '...');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Nova Prototype Test 7', 5, 0, DATEADD(MONTH, 7, '2024-01-01'), DATEADD(MONTH, 7, '2024-01-01'), CASE WHEN 7 IN (3, 5, 7) THEN 2 ELSE 3 END, 'Nova Test', CASE WHEN 7 IN (3, 5, 7) THEN 'Success' ELSE 'Failure' END);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('NOVA-P7', 'Nova Mass Sim 7', 'Test Mass', 50000000, 1, 1, CASE WHEN 7 IN (3, 5, 7) THEN 37 ELSE 28 END);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 1, CASE WHEN 7 IN (3, 5, 7) THEN 2 ELSE 3 END);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 1', 'EXCN1-10007', CASE WHEN 7 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Stage 1');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior Nova Stage 2', 'EXCN1-20007', CASE WHEN 7 IN (3, 5, 7) THEN 1 ELSE 28 END);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

INSERT INTO contracts (contractor_id, contract_title, contract_signed_date, contract_value_eur, contract_details) VALUES (2, 'NASA Artemis Gateway Logistics', GETDATE(), 4000000000.00, 'Gateway');
SET @ContractID = SCOPE_IDENTITY();
INSERT INTO missions (mission_name, launch_pad_id, is_crewed_mission, launch_datetime_net, launch_datetime_scheduled, mission_status_code, mission_description, post_mission_summary)
VALUES ('Artemis Gateway-1', 1, 0, DATEADD(YEAR, 1, GETDATE()), DATEADD(YEAR, 1, GETDATE()), 8, 'Gateway Module', NULL);
SET @MissionID = SCOPE_IDENTITY();
INSERT INTO payloads (payload_serial, payload_name, payload_type, payload_mass_g, manufacturer_id, customer_id, payload_status_code)
VALUES ('GW-1', 'Gateway Hab', 'Lander', 15000000, 1, 2, 1);
SET @PayloadID = SCOPE_IDENTITY();
INSERT INTO payload_mission_manifests (mission_id, payload_id, target_orbit_id, deploy_status_code) VALUES (@MissionID, @PayloadID, 6, 5);
SET @ManifestID = SCOPE_IDENTITY();
INSERT INTO contract_manifest_links (manifest_id, contract_id) VALUES (@ManifestID, @ContractID);
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 1', 'EXC23-11010', 1);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 1, 'Heavy Core');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 4, 1, 'Heavy Port');
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, 5, 1, 'Heavy Starboard');
INSERT INTO rocket_stages (stage_type, stage_serial, stage_status_code) VALUES ('Excelsior 2 Stage 2', 'EXC23-29001', 1);
INSERT INTO mission_rocket_stages (mission_id, stage_id, stage_number, stage_role) VALUES (@MissionID, SCOPE_IDENTITY(), 2, 'Stage 2');

COMMIT TRANSACTION;
PRINT 'Data successfully inserted.';
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
END CATCH

EXEC sp_MSForEachTable 'ALTER TABLE ? WITH NOCHECK CHECK CONSTRAINT ALL';
GO
