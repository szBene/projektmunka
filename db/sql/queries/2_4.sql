use [Avantvia Mission Control Database]

select first_name + ' ' + last_name as full_name
from astronauts
	inner join status_codes on status_codes.status_code=astronauts.astronaut_status_code and status_codes.status_name = 'Ready'
