use [Avantvia Mission Control Database]

declare @fy_start_month tinyint
set @fy_start_month = 4

declare @current_fy_start date
set @current_fy_start = case 
when month(getdate()) >= @fy_start_month then datefromparts(year(getdate()), @fy_start_month, 1)
else datefromparts(year(getdate())-1, @fy_start_month, 1)
end

select sum(contract_value_eur) as revenue_eur
from contracts
where contracts.contract_id in (
select distinct contracts.contract_id
from contracts
	inner join partner_organizations on contracts.contractor_id = partner_organizations.partner_id and partner_organizations.partner_name = 'NASA'
	inner join contract_manifest_links on contracts.contract_id = contract_manifest_links.contract_id
	inner join payload_mission_manifests on contract_manifest_links.manifest_id = payload_mission_manifests.manifest_id
	inner join missions on payload_mission_manifests.mission_id = missions.mission_id
where cast(isnull(missions.launch_datetime_scheduled, launch_datetime_net) as date) between dateadd(year, -1, @current_fy_start) and dateadd(day, -1, @current_fy_start) )