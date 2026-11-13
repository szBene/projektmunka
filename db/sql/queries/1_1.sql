use [Avantvia Mission Control Database]

select count(*) as landing_crafts, avg(cast(payload_mass_g as decimal(10,2))) as avg_mass_g
from payloads
where payload_type = 'Lander'
