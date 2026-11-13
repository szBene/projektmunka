use [Avantvia Mission Control Database]

select launch_pads.launch_pad_name, launch_sites.launch_site_name
from launch_pads
	inner join launch_sites on launch_pads.launch_site_id=launch_sites.launch_site_id
order by launch_sites.launch_site_id
