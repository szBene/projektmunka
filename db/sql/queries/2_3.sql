use [Avantvia Mission Control Database]

select stage_serial
from rocket_stages
	inner join status_codes on rocket_stages.stage_status_code=status_codes.status_code and status_codes.status_name = 'Ready' and stage_serial like 'EXC2_-1%'
	-- EXC[Variant][Generation]-[Stage][Serial]
	-- i am aware that this technically breaks nf1, however serials are much less likely to change than how *people* call a first stage
