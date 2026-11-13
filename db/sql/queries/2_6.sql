use [Avantvia Mission Control Database]

select contract_title, datediff(day, contract_signed_date, getdate()) as days_since_signed
from contracts
	inner join partner_organizations on contracts.contractor_id=partner_organizations.partner_id and partner_name = 'NASA'