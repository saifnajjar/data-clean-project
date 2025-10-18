select *
from layoffs;


-- remove duplicates
-- standrd data
-- none
-- remoce coloms

select *
from layoffs;

create table layoffs_stage
like layoffs;


select *
from layoffs_stage;

insert layoffs_stage
select *
from layoffs;

select *
from layoffs_stage;

select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions) as ROW_NUM
from layoffs_stage;

with duplicates_cte as(
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions) as ROW_NUM
from layoffs_stage

)
select *
from duplicates_cte 
where company = 'casper';


CREATE TABLE `layoffs_stage2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   `row_num`int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select *
from layoffs_stage2;

insert into layoffs_stage2
select *,
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions) as ROW_NUM
from layoffs_stage;




SET SQL_SAFE_UPDATES = 0;


delete
from layoffs_stage2
where row_num > 1;

select *
from layoffs_stage2
where row_num > 1;


select distinct industry
from layoffs_stage2
order by 1;



select company,trim(company)
from layoffs_stage2;

update layoffs_stage2
set  company = trim(company);



select *
from layoffs_stage2
where   industry  like 'Crypto%';


update layoffs_stage2
set industry ='crypto'
where  industry like 'crypto%';




select *
from layoffs_stage2
where   industry  like 'Crypto%';


select distinct country
from layoffs_stage2
order by 1;

update layoffs_stage2
set country = 'United States'
where country like 'United States%';



select date
from  layoffs_stage2;

ALTER TABLE layoffs_stage2
MODIFY COLUMN `date` DATE;


update layoffs_stage2
set date = str_to_date(date,'%m/%d/%Y');

select *
from  layoffs_stage2

where industry is null or industry =''
;
select *
from  layoffs_stage2
where company ='Airbnb';


select t1.industry,t2.industry
from  layoffs_stage2 t1
join layoffs_stage2 t2
  on t1.company =t2.company
  and t1.location = t2.location
  where (t1.industry is null or t1.industry = '')
  and t2.industry is not null;
  
  update  layoffs_stage2
  set industry = null
  where industry ='';
  
  
  select *
  from layoffs_stage2
  where industry is null;
  update   layoffs_stage2 t1
join layoffs_stage2 t2
  on t1.company =t2.company
   and t1.location = t2.location
   set t1.industry=t2.industry
   where  (t1.industry is null or t1.industry = '')
  and t2.industry is not null;

  select *
  from layoffs_stage2
  where total_laid_off is null and percentage_laid_off is null;
  
  delete 
  
  from layoffs_stage2
  where total_laid_off is null and percentage_laid_off is null;
  
  
  alter table layoffs_stage2
  drop column row_num;
  select *
  from layoffs_stage2
