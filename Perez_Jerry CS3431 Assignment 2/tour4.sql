drop table Reservation;
drop table Customer;
drop table Tour;
drop table Guide;
drop table Location;


--Customer Table 
create Table Customer
(
customerID number(4),
firstName varchar2(15),
lastName varchar2(15),
address varchar2(25),
phone number(10) not null,
age number(3),
constraint Customer_PK primary key(customerID),
constraint Customer_ageval check (age >= 5),
constraint Customer_phone_UQ unique (phone)
);

--Creating a sequence for the primary key
create sequence CustomerID_seq
start with 5
increment by 5;

--Inserting Customer values
insert into Customer values(CustomerID_seq.nextval,'Michael','Ward','143 Cambridge Ave.',5082328798,45);
insert into Customer values(CustomerID_seq.nextval,'Lisa','Gray','77 Massachusetts Ave.',6174153059,68);
insert into Customer values(CustomerID_seq.nextval,'Brian','Myers','175 Forest St.',2123043923,19);
insert into Customer values(CustomerID_seq.nextval,'Nicole','Ross','35 Tremont St.',7818914567,42);
insert into Customer values(CustomerID_seq.nextval,'Kelly','Powell','100 Main St.',8915367188,57);
insert into Customer values(CustomerID_seq.nextval,'Madison','Martin','42 Oak St.',1233753684,16);
insert into Customer values(CustomerID_seq.nextval,'Ashley','White','1414 Cedar St.',6428369619,18);
insert into Customer values(CustomerID_seq.nextval,'Joshua','Clark','42 Elm Place',1946825344,22);
insert into Customer values(CustomerID_seq.nextval,'Tyler','Young','9 Washington Court',9864752346,25);
insert into Customer values(CustomerID_seq.nextval,'Anna','Powell','98 Lake Hill Drive',8946557732,17);
insert into Customer values(CustomerID_seq.nextval,'Justin','Allen','657 Redondo Ave.',7988641411,18);
insert into Customer values(CustomerID_seq.nextval,'Bruce','Sanchez','5 Jefferson Ave.',2324648888,26);
insert into Customer values(CustomerID_seq.nextval,'Rachel','Lee','8711 Meadow St.',2497873464,67);
insert into Customer values(CustomerID_seq.nextval,'Dylan','Garcia','17 Valley Drive',9865553232,20);
insert into Customer values(CustomerID_seq.nextval,'Austin','Davis','1212 8th St.',4546667821,29);

select * from Customer;

--Tour Table
create Table Tour
(
tourID number(3),
tourName varchar2(25),
description varchar2(40),
city varchar2(15),
state char(2),
vehicleType varchar2(15),
constraint Tour_PK primary key(tourID),
constraint Tour_vehicleTypecheck check (vehicleType = 'duckboat' or vehicleType ='bus' or vehicleType = 'car')
);

--Creating a sequence for the primary key
create sequence TourID_seq
start with 1
increment by 1;

--Inserting Tour values
insert into Tour values(TourID_seq.nextval,'Duck Tour','Amphibious tour of the Charles River','Boston','MA','duckboat');
insert into Tour values(TourID_seq.nextval,'Freedom Trail','Historic tour of Boston','Boston','MA','bus');
insert into Tour values(TourID_seq.nextval,'Magnificent Mile Tour','Tour of Michigan Ave','Chicago','IL','bus');
insert into Tour values(TourID_seq.nextval,'City Sights','Highlights of New York City','New York','NY','car');
insert into Tour values(TourID_seq.nextval,'Golden Gate','Tour of Golden Gate Park','San Francisco','CA','bus');

select * from Tour;

--Guide Table
create Table Guide
(
guideID number(3),
firstName varchar2(15),
lastName varchar2(15),
phone number (10,0),
vehicleType varchar2(15),
title varchar2(15),
salary number(5),
constraint Guide_PK primary key(guideID),
constraint Guide_vehicleTypecheck check (vehicleType = 'duckboat' or vehicleType ='bus' or vehicleType = 'car')
);

--Creating a sequence for the primary key
create sequence GuideID_seq
start with 101
increment by 1;

--Inserting Guide values
insert into Guide values(GuideID_seq.nextval,'Noah','Smith','5082391452','bus','Junior Guide',22000);
insert into Guide values(GuideID_seq.nextval,'Liam','Johnson','7812930638','bus','Guide',31000);
insert into Guide values(GuideID_seq.nextval,'Mason','Williams','6174920983','car','Senior Guide',45000);
insert into Guide values(GuideID_seq.nextval,'Olivia','Brown','6672930684','duckboat','Guide',32000);
insert into Guide values(GuideID_seq.nextval,'Sofia','Jones','4150973848','bus','Senior Guide',49000);
insert into Guide values(GuideID_seq.nextval,'Emily','Miller','3058442323','car','Junior Guide',25000);
insert into Guide values(GuideID_seq.nextval,'Ethan','Davis','4156719583','bus','Junior Guide',24000);
insert into Guide values(GuideID_seq.nextval,'Chloe','Garcia','8193291234','duckboat','Guide',30000);
insert into Guide values(GuideID_seq.nextval,'Ben','Rodriguez','8458799394','bus','Junior Guide',27000);
insert into Guide values(GuideID_seq.nextval,'Mia','Wilson','5088314545','car','Senior Guide',47000);

select * from Guide;

--Location Table
create Table Location
(
locationName varchar2(30),
locationType varchar2(10),
address varchar2(40),
tourID number (3),
constraint Location_PK primary key(locationName),
constraint Location_tourID_FK foreign key(tourID) references Tour(tourID)
);

--Inserting Location values
insert into Location values('Charles River','Historic','10 Mass Avenue',1);
insert into Location values('Salt and Pepper Bridge','Historic','100 Broadway',1);
insert into Location values('Boston Common','Park','139 Tremont Street',2);
insert into Location values('Kings Chapel','Historic','58 Tremont Street',2);
insert into Location values('Omni Parker House','Restaurant','60 School Street',2);
insert into Location values('Paul Revere House','Historic','19 North Square',2);
insert into Location values('Bunker Hill Monument','Historic','Monument Square',2);
insert into Location values('Art Institute','Museum','111 S Michigan Avenue',3);
insert into Location values('Chicago Tribune','Historic','435 N Michigan Avenue',3);
insert into Location values('White Castle','Restaurant','S Wabash Avenue',3);
insert into Location values('Freedom Tower','Historic','285 Fulton Street',4);
insert into Location values('Le Bernardin','Restaurant','155 W 51 Street',4);
insert into Location values('Park Aquarium','Museum','55 Music Concourse Drive',5);
insert into Location values('de Young Museum','Museum','50 Hagiwara Tea Garden Drive',5);
insert into Location values('Japanese Tea Garden','Park','75 Hagiwara Tea Garden Drive',5);
insert into Location values('Botanical Garden','Park','1199 9th Avenue',5);

select * from Location;

--Reservation Table
create Table Reservation
(
reservationID number(4),
travelDate date,
customerID number(4),
tourID number(3),
guideID number(3),
price number(5,2),
constraint Reservation_PK primary key(reservationID),
constraint Reservation_customerID_FK foreign key(customerID) references Customer(customerID) on delete set null,
constraint Reservation_tourID_FK foreign key(tourID) references Tour(tourID) on delete set null,
constraint Reservation_guideID_FK foreign key(guideID) references Guide(guideID) on delete set null
);

--Creating a sequence for the primary key
create sequence ReservationID_seq
start with 100
increment by 10;

--Inserting Reservation values
insert into Reservation values(ReservationID_seq.nextval,'15-Mar-16',25,2,105,null);
insert into Reservation values(ReservationID_seq.nextval,'28-Feb-16',5,4,101,null);
insert into Reservation values(ReservationID_seq.nextval,'3-Jun-16',25,1,104,null);
insert into Reservation values(ReservationID_seq.nextval,'17-May-16',20,4,102,null);
insert into Reservation values(ReservationID_seq.nextval,'11-Apr-16',15,2,109,null);
insert into Reservation values(ReservationID_seq.nextval,'24-Nov-16',10,5,108,null);
insert into Reservation values(ReservationID_seq.nextval,'3-Aug-16',20,3,103,null);
insert into Reservation values(ReservationID_seq.nextval,'13-Dec-16',70,2,110,null);
insert into Reservation values(ReservationID_seq.nextval,'9-Nov-16',25,5,107,null);
insert into Reservation values(ReservationID_seq.nextval,'21-Jan-16',45,1,105,null);
insert into Reservation values(ReservationID_seq.nextval,'6-Feb-16',65,5,108,null);
insert into Reservation values(ReservationID_seq.nextval,'31-Aug-16',40,1,102,null);
insert into Reservation values(ReservationID_seq.nextval,'10-Apr-16',75,3,106,null);
insert into Reservation values(ReservationID_seq.nextval,'29-Jul-16',50,3,102,null);
insert into Reservation values(ReservationID_seq.nextval,'15-Oct-16',30,2,110,null);
insert into Reservation values(ReservationID_seq.nextval,'8-Mar-16',70,3,103,null);
insert into Reservation values(ReservationID_seq.nextval,'11-Dec-16',55,4,109,null);
insert into Reservation values(ReservationID_seq.nextval,'12-Aug-16',35,4,107,null);
insert into Reservation values(ReservationID_seq.nextval,'22-Jun-16',70,1,107,null);
insert into Reservation values(ReservationID_seq.nextval,'1-Feb-16',60,5,101,null);

select * from Reservation;

--Part 3

select L.locationType, count(distinct C.customerID) as NumberofCustomers
from Location L join Reservation R
on L.tourID = R.tourID join Customer C
on R.customerID = C.customerID
group by L.locationType;


--Part 4

select R.reservationID, T.tourName, T.vehicleType, G.firstName, G.lastName, G.vehicleType
from Reservation R join Tour T
on R.tourID = T.tourID join Guide G
on R.guideID = G.guideID
where G.vehicleType != T.vehicleType
order by T.tourName;



--Part 5
            
select city, maxnum as NumberOfTours
from 
(
    select city, count(reservationID) as maxnum
    from Reservation R join Tour T 
    on R.tourID = T.tourID
    group by city
    )
where maxnum = (
select max(maxnum)
from(
    select city, count(reservationID) as maxnum
    from Reservation R join Tour T 
    on R.tourID = T.tourID
    group by city));


--Part 6
--part a
update Reservation
set price = 100
where reservationID IN
(select R.reservationID
from Reservation R join Customer C
on R.customerID = C.customerID join Tour T
on R.tourID = T.tourID
where (T.city = 'Boston' and C.age > 21));

--part b
update Reservation
set price = 25
where reservationID IN
(select R.reservationID
from Reservation R join Customer C
on R.customerID = C.customerID join Tour T
on R.tourID = T.tourID
where (T.city = 'Boston' and C.age < 21));

select * from Reservation;

--part c
select R.reservationID, C.firstName, C.lastName, T.tourName, T.city, C.age, R.price
from Reservation R join Customer C
on R.customerID = C.customerID join Tour T
on R.tourID = T.tourID
where T.tourName LIKE '%Tour%'
order by city, age;