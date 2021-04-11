DROP TABLE C_Campus  CASCADE CONSTRAINTS;
DROP TABLE C_Position CASCADE CONSTRAINTS;
DROP TABLE C_Members CASCADE CONSTRAINTS;
DROP TABLE C_Prices CASCADE CONSTRAINTS;
DROP TABLE C_FoodItems CASCADE CONSTRAINTS;
DROP TABLE C_Orders CASCADE CONSTRAINTS;
DROP TABLE C_OrderLine CASCADE CONSTRAINTS;
DROP SEQUENCE PRICES_FOODITEMTYPEID_SEQ;

CREATE TABLE C_Campus (
CampusID VARCHAR2(3)PRIMARY KEY,
CampusName VARCHAR2(25),
Street VARCHAR2(30),
City VARCHAR2(20),
State VARCHAR2(3), 
Zip VARCHAR2(5),
Phone VARCHAR2(15),
CampusDiscount Number(4,2));

INSERT INTO C_Campus VALUES('1','IUPUI','425 University Blvd.','Indianapolis', 'IN','46202', '317-274-4591',.08);
INSERT INTO C_Campus VALUES('2','Indiana University','107 S. Indiana Ave.','Bloomington', 'IN','47405', '812-855-4848',.07);
INSERT INTO C_Campus VALUES('3','Purdue University','475 Stadium Mall Drive','West Lafayette', 'IN','47907', '765-494-1776',.06);


CREATE TABLE C_Position (
PositionID VARCHAR2(3) PRIMARY KEY,
Position VARCHAR2(30),
YearlyMembershipFee NUMBER(6,2));

INSERT INTO C_Position VALUES('1','Lecturer', 1050.50);
INSERT INTO C_Position VALUES('2','Associate Professor', 900.50);
INSERT INTO C_Position VALUES('3','Assistant Professor', 875.50);
INSERT INTO C_Position VALUES('4','Professor', 700.75);
INSERT INTO C_Position VALUES('5','Full Professor', 500.50);


CREATE TABLE C_Members (
MemberID VARCHAR2(3)PRIMARY KEY,
LastName VARCHAR2(15), 
FirstName VARCHAR2(15), 
CampusAddress VARCHAR2(30), 
CampusPhone VARCHAR2(15), 
CampusID VARCHAR2(3),
PositionID VARCHAR2(3),
ContractDuration NUMBER(2),
CONSTRAINT C_CAMPUS_C_CAMPUSID_fk FOREIGN KEY (CAMPUSID) REFERENCES C_CAMPUS(CAMPUSID),
CONSTRAINT C_POSITION_C_PositionID_fk FOREIGN KEY (PositionID) REFERENCES  C_POSITION(PositionID)); 


INSERT INTO C_Members VALUES('1','Ellen','Monk','009 Purnell', '812-123-1234', '2', '5', 12);
INSERT INTO C_Members VALUES('2','Joe','Brady','008 Statford Hall', '765-234-2345', '3', '2', 10);
INSERT INTO C_Members VALUES('3','Dave','Davidson','007 Purnell', '812-345-3456', '2', '3', 10);
INSERT INTO C_Members VALUES('4','Sebastian','Cole','210 Rutherford Hall', '765-234-2345', '3', '5', 10);
INSERT INTO C_Members VALUES('5','Michael','Doo','66C Peobody', '812-548-8956', '2', '1', 10);
INSERT INTO C_Members VALUES('6','Bob','House','ET 329', '317-278-9098', '1', '4', 10);
INSERT INTO C_Members VALUES('7','Bridget','Stanley','SI 234', '317-274-5678', '1', '1', 12);
INSERT INTO C_Members VALUES('8','Bradley','Wilson','334 Statford Hall', '765-258-2567', '3', '2', 10);


CREATE SEQUENCE Prices_FoodItemTypeID_SEQ
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE C_Prices (
FoodItemTypeID    varchar2(5) PRIMARY KEY,
MealType          varchar2(100),
MealPrice         decimal(7,2));

INSERT INTO C_Prices VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Beer/Wine', 5.50);
INSERT INTO C_Prices VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Dessert', 2.75);
INSERT INTO C_Prices VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Dinner', 15.50);
INSERT INTO C_Prices VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Soft Drink', 2.50);
INSERT INTO C_Prices VALUES (Prices_FoodItemTypeID_SEQ.NEXTVAL, 'Lunch', 7.25);

CREATE TABLE C_FoodItems (
FoodItemID      varchar2(5)PRIMARY KEY,
FoodItemName    varchar2(100),
FoodItemTypeID  varchar2(5));

ALTER TABLE C_FoodItems ADD CONSTRAINT C_FoodItems_FoodItemID_FK
FOREIGN KEY (FoodItemTypeID) REFERENCES C_Prices;

INSERT INTO C_FoodItems VALUES ('10001', 'Lager', '1');
INSERT INTO C_FoodItems VALUES ('10002', 'Red Wine', '1');
INSERT INTO C_FoodItems VALUES ('10003', 'White Wine', '1');
INSERT INTO C_FoodItems VALUES ('10004', 'Coke', '4');
INSERT INTO C_FoodItems VALUES ('10005', 'Coffee', '4');
INSERT INTO C_FoodItems VALUES ('10006', 'Chicken a la King', '3');
INSERT INTO C_FoodItems VALUES ('10007', 'Rib Steak', '3');
INSERT INTO C_FoodItems VALUES ('10008', 'Chips', '3');
INSERT INTO C_FoodItems VALUES ('10009', 'Veggie Delight', '3');
INSERT INTO C_FoodItems VALUES ('10010', 'Chocolate Mousse', '2');
INSERT INTO C_FoodItems VALUES ('10011', 'Carrot Cake', '2');
INSERT INTO C_FoodItems VALUES ('10012', 'Fruit Cup', '2');
INSERT INTO C_FoodItems VALUES ('10013', 'Chips', '5');
INSERT INTO C_FoodItems VALUES ('10014', 'Angus and Chips', '5');
INSERT INTO C_FoodItems VALUES ('10015', 'Cobb Salad', '5');


CREATE TABLE C_Orders (
OrderID NUMBER(3) PRIMARY KEY,
MemberID VARCHAR2(3),
OrderDate DATE,
CONSTRAINT C_ORDERS_MemberID_fk FOREIGN KEY (MemberID) REFERENCES C_MEMBERS(MemberID));

INSERT INTO C_Orders VALUES('1', '5', '31-MAR-20');
INSERT INTO C_Orders VALUES('2', '8', '11-MAY-20');
INSERT INTO C_Orders VALUES('3', '7', '30-JUN-20');
INSERT INTO C_Orders VALUES('4', '3', '22-SEP-20');
INSERT INTO C_Orders VALUES('5', '5', '05-SEP-20');
INSERT INTO C_Orders VALUES('6', '4', '17-SEP-20');
INSERT INTO C_Orders VALUES('7', '3', '19-OCT-20');
INSERT INTO C_Orders VALUES('8', '7', '14-OCT-20');
INSERT INTO C_Orders VALUES('9', '1', '06-OCT-20');


CREATE TABLE C_OrderLine (
OrderID      NUMBER(3),
FoodItemID  varchar2(5),
Quantity     NUMBER(3),
CONSTRAINT OrderLine_ORDERFOODIDS_PK PRIMARY KEY (OrderID, FoodItemID),
CONSTRAINT Orders_OrderID_FK  FOREIGN KEY (OrderID) REFERENCES C_Orders(OrderID),
CONSTRAINT Orders_C_FoodItemsID_FK FOREIGN KEY (FoodItemID)REFERENCES C_FoodItems(FoodItemID));

INSERT INTO C_OrderLine VALUES ( '1', '10001', 1 );
INSERT INTO C_OrderLine VALUES ( '1', '10006', 1 );
INSERT INTO C_OrderLine VALUES ( '1', '10012', 1 );
INSERT INTO C_OrderLine VALUES ( '2', '10004', 2 );
INSERT INTO C_OrderLine VALUES ( '2', '10013', 3 );
INSERT INTO C_OrderLine VALUES ( '2', '10014', 1 );
INSERT INTO C_OrderLine VALUES ( '3', '10005', 4 );
INSERT INTO C_OrderLine VALUES ( '3', '10011', 1 );
INSERT INTO C_OrderLine VALUES ( '4', '10005', 2 );
INSERT INTO C_OrderLine VALUES ( '4', '10004', 2 );
INSERT INTO C_OrderLine VALUES ( '4', '10006', 1 );
INSERT INTO C_OrderLine VALUES ( '4', '10007', 3 );
INSERT INTO C_OrderLine VALUES ( '4', '10010', 2 );
INSERT INTO C_OrderLine VALUES ( '5', '10003', 1 );
INSERT INTO C_OrderLine VALUES ( '6', '10002', 2 );
INSERT INTO C_OrderLine VALUES ( '7', '10005', 2 );
INSERT INTO C_OrderLine VALUES ( '8', '10005', 3 );
INSERT INTO C_OrderLine VALUES ( '8', '10011', 1 );
INSERT INTO C_OrderLine VALUES ( '9', '10001', 1 );

COMMIT;



