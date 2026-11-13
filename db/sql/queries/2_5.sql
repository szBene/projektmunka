use [Avantvia Mission Control Database]

select top 3 with ties
	launch_pads.launch_pad_name, count(missions.mission_id) as launch_count
from launch_pads
	inner join missions on missions.launch_pad_id=launch_pads.launch_pad_id
where datediff(day, missions.launch_datetime_scheduled, getdate()) between 0 and 365
group by launch_pads.launch_pad_name
order by launch_count desc
