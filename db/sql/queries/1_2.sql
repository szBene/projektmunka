use [Avantvia Mission Control Database]

declare @fy_start_month tinyint = 4;

select
    -- if the month is less than the start month, it belongs to the fiscal year started in the previous calendar year
    case 
        when month(contract_signed_date) >= @fy_start_month 
        then year(contract_signed_date) 
        else year(contract_signed_date) - 1 
    end as fiscal_year,
    count(*) as contract_count,
    sum(contract_value_eur) as total_value_eur
from contracts
group by 
    case 
        when month(contract_signed_date) >= @fy_start_month 
        then year(contract_signed_date) 
        else year(contract_signed_date) - 1 
    end
order by fiscal_year desc;