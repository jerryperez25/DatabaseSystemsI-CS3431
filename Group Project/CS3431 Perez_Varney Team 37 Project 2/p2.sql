-- Jerry Perez and Thomas Cole Varney // Team 37 // Project 2
-- Problem 1
create view NoCurator as 
    select O.locationID,S.accountName
    from Location L join Office O
    on L.locationID = O.locationID join Staff S
    on O.locationID = S.locationID join StaffPosition SP
    on S.accountName = SP.accountName
    where SP.positionID <> 'CURATOR';
    
drop view NoCurator;
    
select locationID, count(accountName)as CNT
from NoCurator
group by locationID;

--Problem 2
create procedure StaffInOffice (LocationID varchar2) Is
    tempLoc varchar2(20);
    tempOcc number(2);
    tempLocCnt number(2);

    Begin
        select count(S.locationID), S.locationID, o.maxOccupancy into tempLocCnt,tempLoc,tempOcc
        from Staff S join Office O
        on S.locationID = O.locationID
        where S.locationID = StaffInOffice.LocationID
        group by S.locationID, maxOccupancy;
        dbms_output.put_line('Office '||LocationID|| ': '||tempLocCnt || ' assigned,' || tempOcc || ' max occupancy');
    End;
/

set serveroutput on;
exec StaffInOffice('205');
drop procedure StaffInOffice;

--Problem 3

create or replace trigger NoSameStartEnd
after insert on Edge
for each row
    Begin
        if (:new.startingID = :new.endingID)
        then 
            RAISE_APPLICATION_ERROR(-20001, 'INSERT ERROR: startingID and endingID are the same');
    
        end if;
    End;
/

drop trigger NoSameStartEnd;


--Problem 4

create or replace trigger OnlyStaircases
before insert on Edge
for each row
declare 
    beginFloor number;
    endFloor number;
    startType varchar2(50);
    endType varchar2(50);
begin 
    select floor
    into beginFloor
    from Location
    where :new.startingID = locationID;
    
    select floor
    into endFloor
    from Location 
    where :new.endingId = locationID;
    
    select locationType
    into startType
    from Location 
    where :new.startingId = locationID;
    
    select locationType
    into endType
    from Location
    where :new.endingID = locationID;
    
    if(startType != 'Stairs' or endType != 'Stairs') 
    then
        if(beginFloor != endFloor) then
            RAISE_APPLICATION_ERROR(-20002, 'INSERT ERROR: Only stairs can have edges on different floors');
        end if;
    end if;
    if(startType = 'Stairs' and endType = 'Stairs')
    then
        if(beginFloor = endFloor)
        then
            RAISE_APPLICATION_ERROR(-20003, 'INSERT ERROR: Stair edges must connect to different floors');
        end if;
    end if;
    
end;
/

drop trigger OnlyStairCases;

-- Problem 5

create or replace trigger MustBeOffice
before insert or update on Office
for each row
declare 
    officeLocationType varchar2(30);
    
    
    Cursor b1 (newOfficeID varchar2) is
        select L.locationType
        from Office O join Location L
        on O.locationID = L.locationID;
    
        
    Begin
    
        select L.locationType into officeLocationType
        from Office O join Location L
        on O.locationID = L.locationID
        where L.locationID = :new.locationID;
        
        --TEST ANY RECORD
        if(officeLocationType != 'Office') then    
            RAISE_APPLICATION_ERROR(-20004, 'INSERT ERROR: locationID is not a valid office location.');
        end if;
        
        --TEST EXISTING RECORDS
        for typeRow in b1 (:new.locationID) loop
            if (typeRow.locationType != 'Office') then
            RAISE_APPLICATION_ERROR(-20005, 'EXISTING ROW ERROR: TThere is an existing record that does not have Office as locationType.');
            end if;
        end loop;
    End;
/

drop trigger MustBeOffice;

--Problem 6

create or replace trigger JobLimit
after insert or update on StaffPosition
declare     
    Cursor counter is 
        select count(positionID) as CNT, accountName
        from StaffPosition
        group by accountName;
    Begin
        for counterRow in counter loop
            if (counterRow.CNT > 3) then
                RAISE_APPLICATION_ERROR(-20006, 'EXISTING ROW ERROR: Staff members cannot have more than 3 positions ');
            end if;
        end loop;
    End;
/ 

drop trigger JobLimit;




    



