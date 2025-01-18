use revision;
select * 
from flights;

select distinct Destination 
from flights;

update flights
set Destination = 'New Delhi'
where Destination = 'Delhi';

select distinct Source 
from flights;

update flights
set Source = 'New Delhi'
where Source = 'Delhi';
