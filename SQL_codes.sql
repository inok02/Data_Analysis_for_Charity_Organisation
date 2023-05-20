-- Insight 1 - Total Amount Donanted 
select sum(donation) as TotalAmountDonated 
from Donation_Data;

-- Insight 2 - Total Numebr of Donors in the database 
select count(*) as TotalNumberOfDonors
from Donation_Data;

-- Insight 3 - Top five male donors 
select first_name, last_name, gender, donation
from Donation_Data
where gender = 'Male'
order by donation desc
limit 5;

-- Insight 4 - Top five female donors 
select first_name, last_name, gender, donation
from Donation_Data
where gender = 'Female'
order by donation desc
limit 5;

-- Insight 5 - Gender distribution of donors 
select gender, count(donation) as TotalCount
from Donation_Data
group by gender;

-- Insight 6 - Total donations recieved from male donors ($127,628) 
select sum(donation) as Total_male_donations
from Donation_Data
where gender = 'Male';

-- Insight 7 - Total donations recieved from female donors ($121,457)
select sum(donation) as Total_female_donations
from Donation_Data
where gender = 'Female';

-- Insight 8 - Average donation recived
select round(avg(donation), 2) as Average_donation
from Donation_Data;

-- Insight 9 - Maximum and mminimum amounts donated
select max(donation) as Highest_donated_amount,
(select min(donation) from Donation_Data) as Lowest_donated_amount
from Donation_Data;

-- Insight 10 - Minimum amount donated
select min(donation)
from Donation_Data;

-- Insight 10 - How frequently did the top 5 donors donate?
select d.id, donation, donation_frequency
from Donation_Data d
join Donor_Data2 don
on d.id = don.id
order by donation desc
limit 5;

-- Insight 11 - Total donations received yearly
select sum(donation) as Total_yearly_donation
from Donation_Data d
where id in (
	select id 
	from Donor_Data2
	where donation_frequency = 'Yearly');
    
-- Insight 12 - Total donations by male and female
select gender, sum(donation) as Total_donation_by_gender
from Donation_Data d
where gender in (
	select gender 
	from Donation_Data)
group by gender
order by Total_donation_by_gender desc;

-- Insight 13 - Maximum donations by gender
select gender, max(donation) as max_donation_by_gender
from Donation_Data d
where gender in (
	select gender 
	from Donation_Data)
group by gender
order by max_donation_by_gender desc;

-- Insight 13 - Minimum donations by gender
select gender, min(donation) as min_donation_by_gender
from Donation_Data d
where gender in (
	select gender 
	from Donation_Data)
group by gender
order by min_donation_by_gender;

-- Insight 14 - Yearly donations by gender distribution
select d.gender, sum(d.donation) as YearlyDonationByGender
from Donation_Data d
left join Donor_Data2 don
	on d.id = don.id
where don.donation_frequency = 'Yearly'
group by gender
order by d.donation desc;

-- Insight 15 - Donor categorization and count
select
case 
	when d.donation >= 400 then '400 Above'
    when d.donation >= 200 and d.donation < 400 then 'Between 200 and 400'
    when d.donation >= 100 and d.donation < 200 then 'Silver donor'
End as Donor_category, count(*) as Donor_Count
from Donation_Data d
left join Donor_Data2 don
	on d.id = don.id
group by Donor_category
order by Donor_Count desc;

-- Insight 16 - Joining both tables together
SELECT don.id, don.first_name, don.last_name, don.gender, don.job_field, don.donation,
don.state, donor.donation_frequency, donor.university, donor.car, donor.second_language,
donor.favourite_colour, donor.movie_genre
from Donation_Data don 
left outer JOIN Donor_Data2 donor 
on don.id = donor.id;

-- Insight 17 - Total contributions per job field
select job_field, sum(donation) as contribution
from Donation_Data d
group by job_field
order by contribution desc
--limit 10;