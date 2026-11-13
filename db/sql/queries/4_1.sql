use [Avantvia Mission Control Database]

select stage_serial
from rocket_stages
	inner join mission_rocket_stages on rocket_stages.stage_id = mission_rocket_stages.stage_id
	inner join
	(select top 1 with ties
		mission_id, launch_datetime_net
	from missions
	where missions.mission_status_code in 
	(select status_code
	from status_codes
	-- its not necessary to join here, and because why not have a two level subquery, lmao
	where status_name in ('Success', 'Failure', 'Partial Failure', 'Under Analysis')) and isnull(launch_datetime_scheduled, missions.launch_datetime_net) < getdate()
	-- under analysis means the mission has ended and teams are evaluating telemetry data related to anomalies and failures
	-- this also indicates that missions.post_mission_summary is null or not complete
	order by isnull(missions.launch_datetime_scheduled, launch_datetime_net) desc
) as most_recent_mission_id on mission_rocket_stages.mission_id = most_recent_mission_id.mission_id
-- joining with missions is not necessary. i dont actually care about any of its columns, and i already filtered the mission in the subquery
order by stage_serial asc