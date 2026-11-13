use [Avantvia Mission Control Database]

select contracts.contract_title, contracts.contract_value_eur, missions.mission_name, missions.launch_datetime_net, payloads.payload_name, payloads.payload_type
from contract_manifest_links
	inner join
	(select top 1 with ties 
		contracts.contract_id
	from contracts
		inner join contract_manifest_links on contracts.contract_id = contract_manifest_links.contract_id
		inner join payload_mission_manifests on contract_manifest_links.manifest_id = payload_mission_manifests.manifest_id
		inner join missions on payload_mission_manifests.mission_id = missions.mission_id and isnull(missions.launch_datetime_scheduled, missions.launch_datetime_net) > getdate()
	group by contracts.contract_id, contracts.contract_value_eur -- remove duplicates
	order by contracts.contract_value_eur desc
) as most_valuable_contract on contract_manifest_links.contract_id = most_valuable_contract.contract_id
	inner join contracts on most_valuable_contract.contract_id = contracts.contract_id
	inner join payload_mission_manifests on contract_manifest_links.manifest_id = payload_mission_manifests.manifest_id
	inner join payloads on payload_mission_manifests.payload_id = payloads.payload_id
	inner join missions on payload_mission_manifests.mission_id = missions.mission_id