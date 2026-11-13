use [Avantvia Mission Control Database]
go

drop procedure if exists cargo_mission_report print 'cargo_mission_report already in db, overwritten'
drop procedure if exists crewed_mission_report print 'crewed_mission_report already in db, overwritten'
drop procedure if exists get_mission_report print 'get_mission_report already in db, overwritten'
go

create procedure cargo_mission_report
	@mission_id smallint
as
begin
	select missions.mission_name, mission_status.status_name as mission_status_name, missions.mission_description, missions.launch_datetime_net,
		payloads.payload_name, payloads.payload_type, payloads.payload_mass_g,
		payload_manufacturer.partner_name as manufacturer_name,
		payload_status.status_name as payload_status_name,
		target_orbits.orbit_name,
		payload_customer.partner_name as customer_name,
		contracts.contract_title, contracts.contract_value_eur
	from missions
		inner join status_codes as mission_status on missions.mission_id = @mission_id and missions.mission_status_code = mission_status.status_code
		inner join payload_mission_manifests on missions.mission_id = payload_mission_manifests.mission_id
		inner join payloads on payload_mission_manifests.payload_id = payloads.payload_id
		inner join status_codes as payload_status on payloads.payload_status_code = payload_status.status_code
		inner join partner_organizations as payload_manufacturer on payloads.manufacturer_id = payload_manufacturer.partner_id
		inner join partner_organizations as payload_customer on payloads.customer_id = payload_customer.partner_id
		inner join target_orbits on payload_mission_manifests.target_orbit_id = target_orbits.target_orbit_id
		inner join contract_manifest_links on payload_mission_manifests.manifest_id = contract_manifest_links.manifest_id
		inner join contracts on contract_manifest_links.contract_id = contracts.contract_id
end

go

create procedure crewed_mission_report
	@mission_id smallint
as
begin
	select missions.mission_name, mission_status.status_name as mission_status_name, missions.mission_description, missions.launch_datetime_net,
		astronauts.first_name + ' ' + astronauts.last_name as full_name,
		datediff(year, date_of_birth, missions.launch_datetime_net) 
		- iif(dateadd(year, datediff(year, date_of_birth, cast(missions.launch_datetime_net as date)), date_of_birth) 
		> cast(missions.launch_datetime_net as date), 1, 0) as astronaut_age_at_launch, -- exact age calculation
		astronauts.nationality,
		astronaut_agency.partner_name as agency_name,
		isnull(agency_contracts.contract_title, 'Seat share') as contract_title, agency_contracts.contract_value_eur
	from missions
		inner join status_codes as mission_status on missions.mission_status_code = mission_status.status_code
		inner join astronaut_missions on missions.mission_id = astronaut_missions.mission_id
		inner join astronauts on astronaut_missions.astronaut_id = astronauts.astronaut_id
		inner join partner_organizations as astronaut_agency on astronauts.agency_id = astronaut_agency.partner_id
		-- this allows for seat sharing: when nasa contracts the capsule for a crewed mission, but lets astronauts from other agencies fly under a contract between them.
		-- duplicating the nasa contract in db under a different contractor id will mess with finances, possibly even when duplicating with 0 value, so this is better
		left join (
			select distinct payload_mission_manifests.mission_id, contracts.contract_id, contracts.contract_title, contracts.contract_value_eur, contracts.contractor_id
		from contracts
			inner join contract_manifest_links on contracts.contract_id = contract_manifest_links.contract_id
			inner join payload_mission_manifests on contract_manifest_links.manifest_id = payload_mission_manifests.manifest_id
		) as agency_contracts on missions.mission_id = agency_contracts.mission_id and astronauts.agency_id = agency_contracts.contractor_id
		where missions.mission_id = @mission_id
end

go

create procedure get_mission_report
	@mission_id smallint
as
begin
	declare @is_crewed bit
	select @is_crewed = is_crewed_mission
	from missions
	where mission_id = @mission_id

	if @is_crewed = 1 exec dbo.crewed_mission_report @mission_id
	else exec dbo.cargo_mission_report @mission_id
end