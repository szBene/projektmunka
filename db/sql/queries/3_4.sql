use [Avantvia Mission Control Database]

select rocket_stages.stage_serial,
	missions.mission_name, missions.launch_datetime_scheduled,
	launch_pads.launch_pad_name, launch_sites.launch_site_name, launch_sites.launch_site_country,
	landing_targets.landing_target_name, landing_targets.landing_target_site, landing_targets.landing_target_type,
	isnull(datediff(day, lag(cast(missions.launch_datetime_scheduled as date)) over (partition by rocket_stages.stage_id order by missions.launch_datetime_scheduled), missions.launch_datetime_scheduled), 0) as [turnaround_time]
from rocket_stages
	inner join
	(
select top 1 with ties
		mission_rocket_stages.stage_id as stage_id
	from mission_rocket_stages
		inner join rocket_stages on rocket_stages.stage_id = mission_rocket_stages.stage_id and rocket_stages.stage_serial like 'EXC2_-1%'
	-- serial: EXC[Variant][Generation]-[Stage][Serial]
	group by mission_rocket_stages.stage_id
	order by count(mission_rocket_stages.mission_id) desc
) as most_exc2_flights on rocket_stages.stage_id = most_exc2_flights.stage_id
	inner join mission_rocket_stages on rocket_stages.stage_id = mission_rocket_stages.stage_id
	inner join missions on mission_rocket_stages.mission_id = missions.mission_id
	inner join launch_pads on missions.launch_pad_id = launch_pads.launch_pad_id
	inner join launch_sites on launch_pads.launch_site_id = launch_sites.launch_site_id
	left join stage_landing_target_links on mission_rocket_stages.mission_stage_id = stage_landing_target_links.mission_stage_id
	left join landing_targets on stage_landing_target_links.landing_target_id = landing_targets.landing_target_id
-- left join these because with inner join it wont show up in the flight history when expended
order by missions.launch_datetime_scheduled desc