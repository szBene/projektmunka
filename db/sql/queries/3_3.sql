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
select distinct mission_name, launch_datetime_net, contract_title, contract_value_eur, partner_name
from (select top 1 with ties
		missions.mission_name, missions.launch_datetime_net,
		contracts.contract_title, contracts.contract_value_eur,
		partner_organizations.partner_name
	from missions
		inner join rideshare_missions on missions.mission_id = rideshare_missions.mission_id
		inner join status_codes as mission_status
		on missions.mission_status_code = mission_status.status_code and mission_status.status_name in ('Ready', 'Awaiting', 'To Be Determined', 'Under Planning')
		and (missions.launch_datetime_net >= getdate() or (mission_status.status_name = 'Scrub' and missions.launch_datetime_scheduled is null))
		inner join payload_mission_manifests
		on missions.mission_id = payload_mission_manifests.mission_id
		inner join contract_manifest_links on payload_mission_manifests.manifest_id = contract_manifest_links.manifest_id
		inner join contracts on contract_manifest_links.contract_id = contracts.contract_id
		inner join partner_organizations on contracts.contractor_id = partner_organizations.partner_id
	order by isnull(missions.launch_datetime_scheduled, missions.launch_datetime_net) asc) as next_rideshare
order by next_rideshare.mission_name -- order by mission name for edge case when there are two missions launching at the same time