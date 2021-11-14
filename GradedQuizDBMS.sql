CREATE database TravelTheGo;
use TravelTheGo;
SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE IF NOT EXISTS `PASSENGER` (
`PassengerID` INT NOT NULL AUTO_INCREMENT ,
`Passenger_Name` VARCHAR(20),
`Category` VARCHAR(10),
`Gender` CHAR,
PRIMARY KEY(`PassengerID`)
);

CREATE TABLE IF NOT EXISTS `PRICE` (
`BusID`  INT NOT NULL AUTO_INCREMENT,
`Bus_Type` VARCHAR(20),
`Distance` INT,
`Price` INT,
`Boarding_City` VARCHAR(20),
`Destination_City` VARCHAR(20),
`PassengerID` INT,
PRIMARY KEY(`BusID`),
FOREIGN KEY (`PassengerID`) REFERENCES PASSENGER(`PassengerID`)
);

insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",350,770,"Bengaluru","Chennai",1);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",500,1100,"null","null",null);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",600,1320,"Panaji","Bengaluru",3);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",700,1540,"Panaji","Mumbai",7);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",1000,2200,"Trivandrum","panaji",5);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",1200,2640,"null","null",null);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sleeper",350,434,"Bengaluru","Chennai",1);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",500,620,"Nagpur","Hyderabad",6);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",500,620,"Hyderabad","Bengaluru",8);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",600,744,"null","null",null);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",700,868,"Pune","Nagpur",9);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",700,868,"Mumbai","Hyderabad",2);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",1000,1240,"null","null",null);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",1200,1488,"null","null",null);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",1500,1860,"null","null",null);
insert into `PRICE` (Bus_Type, Distance, Price, Boarding_City, Destination_City, PassengerID) values ("Sitting",1500,null,"Chennai","Mumbai",4);


insert into `Passenger` (Passenger_Name, Category, Gender) values ("Sejal", "AC","F");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Anmol", "Non-AC", "M");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Pallavi", "AC", "F");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Khusboo", "AC", "F");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Udit", "Non-AC", "M");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Ankur", "AC", "M");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Hemant", "Non-AC", "M");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Manish", "Non-AC", "M");
insert into `Passenger` (Passenger_Name, Category, Gender) values ("Piyush", "AC", "M");


-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?

select count(p.gender),p.gender from passenger p inner join price pr on p.PassengerID=pr.PassengerID  where distance >=600 group by p.Gender ;

-- 4) Find the minimum ticket price for Sleeper Bus.
select min(price) from price where bus_type = 'sleeper' group by bus_type;

-- 5) Select passenger names whose names start with character 'S'

select passenger_name from passenger where passenger_name like 's%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
-- Destination City, Bus_Type, Price in the output

select p.Passenger_Name, pr.Boarding_city, pr.Destination_city, pr.bus_type, pr.price from passenger as p inner join price as pr on  p.PassengerID=pr.PassengerID;

-- 7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s
select p.passenger_name , pr.price from passenger as p inner join price as pr on p.PassengerID=pr.PassengerID where pr.distance=1000 and pr.bus_type='sleeper';

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
-- Panaji?
select pr.price from passenger as p inner join price as pr on p.PassengerID=pr.PassengerID where p.passenger_name='pallavi' AND Boarding_City = 'Bengaluru' AND Destination_City = 'Panaji'; 

-- 9) List the distances from the "Passenger" table which are unique (non-repeated
-- distances) in descending order.

select distinct(pr.distance) from passenger as p inner join price as pr on p.PassengerID=pr.PassengerID order by 1 desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger
-- from the total distance travelled by all passengers without using user variables

select passenger_name, pr.distance*100/d.sumpp from passenger as p inner join (select sum(distance) as sumpp from price) as d
inner join price as pr on p.PassengerID=pr.PassengerID group by pr.passengerid;

-- 11) Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000

select distance, price ,
case
when price >1000 then 'expensive'
when price <1000 and price >500 then 'Average'
else 'cheap'
end 
as verdict from price ;