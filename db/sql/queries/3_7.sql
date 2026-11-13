use [Avantvia Mission Control Database]

declare @current_date date
set @current_date = getdate()

select landing_targets.landing_target_name, isnull(landing_targets.landing_target_site, '-') as landing_target_site, landing_targets.landing_target_type, count(stage_landing_target_links.mission_stage_id) as landings_assigned
from landing_targets
	left join stage_landing_target_links on landing_targets.landing_target_id = stage_landing_target_links.landing_target_id
	left join mission_rocket_stages on stage_landing_target_links.mission_stage_id = mission_rocket_stages.mission_stage_id
	left join missions on mission_rocket_stages.mission_id = missions.mission_id and cast(missions.launch_datetime_scheduled as date) between dateadd(year, -1, @current_date) and @current_date
where landing_target_status_code not in (select status_code
from status_codes
where status_name = 'Under Construction')
group by landing_targets.landing_target_name, landing_targets.landing_target_site, landing_targets.landing_target_type
order by landings_assigned desc