use [Avantvia Mission Control Database]
go

with
	rideshare_missions
	as
	(
		select payload_mission_manifests.mission_id
		from payload_mission_manifests
			inner join payloads on payload_mission_manifests.payload_id = payloads.payload_id
		group by payload_mission_manifests.mission_id
		having count(distinct payloads.customer_id) > 1
		-- sats by different operators and the operator is the customer, so manufacturer doesnt matter
	)
select distinct
	mission_name, launch_datetime_net, mission_status_name, payload_name, manufacturer_name, orbit_name, payload_status_name
from (select top 1 with ties
		missions.mission_name, missions.launch_datetime_net, mission_status.status_name as mission_status_name,
		payloads.payload_name, manufacturer.partner_name as manufacturer_name,
		target_orbits.orbit_name, payload_status.status_name as payload_status_name
	from missions
		inner join rideshare_missions on missions.mission_id = rideshare_missions.mission_id
		inner join status_codes as mission_status
		on missions.mission_status_code = mission_status.status_code and mission_status.status_name in ('Ready', 'Awaiting', 'To Be Determined', 'Under Planning')
		and (missions.launch_datetime_net >= getdate() or (mission_status.status_name = 'Scrub' and missions.launch_datetime_scheduled is null))
		inner join payload_mission_manifests
		on missions.mission_id = payload_mission_manifests.mission_id
		inner join payloads
		on payload_mission_manifests.payload_id = payloads.payload_id
		inner join status_codes as payload_status
		on payloads.payload_status_code = payload_status.status_code
		inner join partner_organizations as manufacturer
		on payloads.manufacturer_id = manufacturer.partner_id
		inner join partner_organizations as customer
		on payloads.customer_id = customer.partner_id
		inner join target_orbits
		on payload_mission_manifests.target_orbit_id = target_orbits.target_orbit_id
	order by isnull(missions.launch_datetime_scheduled, missions.launch_datetime_net) asc) as next_rideshare
order by next_rideshare.mission_name -- order by mission name for edge case when there are two missions launching at the same time