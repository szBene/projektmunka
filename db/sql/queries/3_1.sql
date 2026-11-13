use [Avantvia Mission Control Database]

select
	missions.mission_name, missions.mission_description,
	case when astronaut_missions.is_backup = 0 then astronaut_missions.astronaut_role
when astronaut_missions.is_backup = 1 then 'Backup ' + astronaut_missions.astronaut_role
end as 'role',
	astronauts.first_name + ' ' + astronauts.last_name as 'name', partner_organizations.partner_name
from missions
	inner join status_codes on missions.mission_status_code=status_codes.status_code and missions.is_crewed_mission=1
	and status_codes.status_name not in ('Under Planning', 'Under Analysis', 'Cancelled', 'Awaiting', 'Success', 'Failure', 'Partial Failure', 'Scrub')
	inner join astronaut_missions on missions.mission_id=astronaut_missions.mission_id
	inner join astronauts on astronaut_missions.astronaut_id=astronauts.astronaut_id
	inner join partner_organizations on astronauts.agency_id=partner_organizations.partner_id