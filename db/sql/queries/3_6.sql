use [Avantvia Mission Control Database]

select payloads.payload_name,
	partner_organizations.partner_name,
	missions.mission_name
from payloads
	inner join status_codes on payloads.payload_status_code = status_codes.status_code and status_codes.status_name = 'Ready' -- for payloads, ready means ready for integration
	inner join partner_organizations on payloads.customer_id = partner_organizations.partner_id
	inner join payload_mission_manifests on payloads.payload_id = payload_mission_manifests.payload_id
	inner join missions on payload_mission_manifests.mission_id = missions.mission_id
order by missions.launch_datetime_net asc