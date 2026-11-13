use [Avantvia Mission Control Database]

select payload_name
from payloads
	inner join partner_organizations on payloads.customer_id=partner_organizations.partner_id
		and partner_organizations.partner_name = 'NASA'
