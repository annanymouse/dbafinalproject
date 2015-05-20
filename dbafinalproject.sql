create table ArticleAuthors (AuthorID int auto_increment not null, FirstName varchar(50) not null, LastName varchar(50) not null, EmailAddress varchar(100) not null, AuthorBio text not null, primary key(AuthorID)) engine=INNODB;
create table Articles (ArticleID int auto_increment not null, AuthorID int(11) not null, Title varchar(100) not null, Blurb text not null, ArticleText longtext not null, DateWritten datetime not null, primary key(ArticleID, AuthorID)) engine=INNODB;
alter table Articles add Category varchar(100) not null after DateWritten;
alter table Articles engine=MyISAM;
alter table Articles add fulltext(blurb);
create table ArticleCategories(Category varchar(100) not null, ArticleID int(11) not null) engine=INNODB;
create table Commenters(CommenterID int auto_increment not null, FirstName varchar(50) not null, LastName varchar(50) not null, EmailAddress varchar(100) not null, primary key(CommenterID)) engine=INNODB;
create table Comments(CommenterID int(11) not null, ArticleID int(11) not null, Comments text not null, DateCommented datetime not null) engine=INNODB; 
create table ArticleViews(ArticleID int(11) not null, DateViewed datetime not null) engine=INNODB;
drop table if exists ArticleAuthors;

source dba1finalauthors.sql;

/**************BEGIN CONTENT OF dba1finalauthors.sql********************
create table ArticleAuthors (AuthorID int auto_increment, FirstName varchar(50), LastName varchar(50), EmailAddress varchar(100), AuthorBio text, primary key(AuthorID)) engine=INNODB;
delimiter //
create procedure NewAuthor (First varchar(50), Last varchar(50), Email varchar(100), Bio text) begin insert into ArticleAuthors (FirstName, LastName, EmailAddress, AuthorBio) values (First, Last, Email, Bio); END;//
delimiter ;
call NewAuthor ('Lewis', 'Carroll', 'lewis@wonderland.com', 'British');
call NewAuthor ('Charles', 'Dickens', 'charles@pickwickpapers.com', 'British');
call NewAuthor ('John', 'Steinback', 'john@wrathwinery.com', 'American');
call NewAuthor ('Paulo', 'Coehlo', 'pc@alchemy.com', 'Brazilian');
call NewAuthor ('Emily', 'Bronte', 'emily@bronte.com', 'American');
**************END CONTENT OF dba1finalauthors.sql**********************/

source dba1finalarticles.sql

/**************BEGIN CONTENT OF dba1finalarticles.sql********************
delimiter //
create procedure NewArticle (AuthorID int(11), Title varchar(100), Blurb text, ArticleText longtext, DateWritten datetime, Category varchar(100)) begin insert into Articles (AuthorID, Title, Blurb, ArticleText, DateWritten, Category) values (AuthorID, Title, Blurb, ArticleText, DateWritten, Category); END;//
delimiter ;
call NewArticle(1, 'Cheshire Cats Exposed', 'Carroll bares his soul and his life-long love of cats in this tell-all essay', 'Comparing the humped herds of whales with the humped herds of buffalo, which, not forty years ago, overspread by tens of thousands the prairies of Illinois and Missouri, and shook their iron manes and scowled with their thunder-clotted brows upon the sites of populous river-capitals, where now the polite broker sells you land at a dollar an inch; in such a comparison an irresistible argument would seem furnished, to show that the hunted whale cannot now escape speedy extinction.' ,'2014-01-01 13:00:00', 'Non-Fiction');
call NewArticle(2, 'Child Labor in Victorian England', 'Charles Dickens blogs on the historical, economic, and social forces that inspired some of his writings', 'Now this is the strange thing about these germs. There were always new ones coming to live in men\'s bodies. Long and long and long ago, when there were only a few men in the world, there were few diseases. But as men increased and lived closely together in great cities and civilizations, new diseases arose, new kinds of germs entered their bodies. Thus were countless millions and billions of human beings killed. And the more thickly men packed together, the more terrible were the new diseases that came to be. Long before my time, in the middle ages, there was the Black Plague that swept across Europe. It swept across Europe many times. There was tuberculosis, that entered into men wherever they were thickly packed. A hundred years before my time there was the bubonic plague. And in Africa was the sleeping sickness. The bacteriologists fought all these sicknesses and destroyed them, just as you boys fight the wolves away from your goats, or squash the mosquitoes that light on you.' ,'2014-01-15 15:00:00', 'Non-Fiction');
call NewArticle(3, 'Westward Migration, the Dustbowl and the Great Depression', 'John Steinback blogs on the historical, economical, and social forces that inspired his some of his writings', 'The boys were true savages, possessing only the cruel humor of the  savage. To them the incident was excruciatingly funny, and they burst  into loud laughter. Hoo-Hoo danced up and down, while Edwin rolled  gleefully on the ground. The boy with the goats came running to join in  the fun.', '2014-02-01 17:00:00', 'Non-Fiction');
call NewArticle(4, 'Becoming More Mindful Everyday', 'A brief guide to living a more mindful and insightful life every single day', 'Had the Martians aimed only at destruction, they might on Monday have annihilated the entire population of London, as it spread itself slowly through the home counties.  Not only along the road through Barnet, but also through Edgware and Waltham Abbey, and along the roads eastward to Southend and Shoeburyness, and south of the Thames to Deal and Broadstairs, poured the same frantic rout.  If one could have hung that June morning in a balloon in the blazing blue above London every northward and eastward road running out of the tangled maze of streets would have seemed stippled black with the streaming fugitives, each dot a human agony of terror and physical distress.  I have set forth at length in the last chapter my brother\'s account of the road through Chipping Barnet, in order that my readers may realise how that swarming of black dots appeared to one of those concerned. Never before in the history of the world had such a mass of human beings moved and suffered together.  The legendary hosts of Goths and Huns, the hugest armies Asia has ever seen, would have been but a drop in that current.  And this was no disciplined march; it was a stampede--a stampede gigantic and terrible--without order and without a goal, six million people unarmed and unprovisioned, driving headlong.  It was the beginning of the rout of civilisation, of the massacre of mankind.','2014-02-15 19:00:00', 'Inspirational');
call NewArticle(5, 'Poetry For Everyone', 'A article discussing the importance of poetry for people of all ages and background', 'And, offering his arm to Aouda, he directed his steps toward the docks in search of some craft about to start. Fix, stupefied, followed; it seemed as if he were attached to Mr. Fogg by an invisible thread. Chance, however, appeared really to have abandoned the man it had hitherto served so well. For three hours Phileas Fogg wandered about the docks, with the determination, if necessary, to charter a vessel to carry him to Yokohama; but he could only find vessels which were loading or unloading, and which could not therefore set sail. Fix began to hope again.','2014-03-01 21:00:00', 'Poetry');
**************END CONTENT OF dba1finalarticles.sql**********************/

source dba1finalcommenters.sql;

/**************BEGIN CONTENT OF dba1finalcommenters.sql********************
delimiter //
create procedure NewCommenter (First varchar(50), Last varchar(50), Email varchar(100)) begin insert into Commenters (FirstName, LastName, EmailAddress) values (First, Last, Email); END; //
delimiter ;
call NewCommenter('Harry', 'Trolle', 'harrytrolle@underground.com');
call NewCommenter('Tyla', 'Knowles','tyla@knowles.com');
call NewCommenter('Swiss','Robinson','swissrob@treehouse.com');
call NewCommenter('Ritz','Fitzgerald','ritzfitz@gmail.com');
call NewCommenter('Nebula', 'Smith', 'purplenebula@gmail.com');
**************END CONTENT OF dba1finalcommenters.sql**********************/

source dba1finalcomments.sql;

/**************BEGIN CONTENT OF dba1finalcommenter.sql********************
delimiter //
create procedure NewComment (CID int(11), AID int(11), Cmmts text, Date datetime) begin insert into Comments (CommenterID, ArticleID, Comments, DateCommented) values (CID, AID, Cmmts, Date); END; //
delimiter ;
call NewComment(1,1,'Great Article!','2014-01-01 22:00:00');
call NewComment(1,2,'Great Article!','2014-01-15 22:00:00');
call NewComment(1,3,'Great Article!','2014-02-01 22:00:00');
call NewComment(1,4,'Great Article!','2014-02-15 22:00:00');
call NewComment(1,5,'Great Article!','2014-03-01 22:00:00');
call NewComment(2,1,'This article could use some editing!!','2014-01-01 22:00:00');
call NewComment(2,2,'This article could use some editing!!','2014-01-15 22:00:00');
call NewComment(2,3,'This article could use some editing!!','2014-02-01 22:00:00');
call NewComment(2,4,'This article could use some editing!!','2014-02-15 22:00:00');
call NewComment(2,5,'This article could use some editing!!','2014-03-01 22:00:00');
call NewComment(3,1,'I don\'t agree with this article at all.  The author is seriously misinformed.','2014-01-01 22:00:00');
call NewComment(3,2,'I don\'t agree with this article at all.  The author is seriously misinformed.','2014-01-15 22:00:00');
call NewComment(3,3,'I don\'t agree with this article at all.  The author is seriously misinformed.','2014-02-01 22:00:00');
call NewComment(3,4,'I don\'t agree with this article at all.  The author is seriously misinformed.','2014-02-15 22:00:00');
call NewComment(3,5,'I don\'t agree with this article at all.  The author is seriously misinformed.','2014-03-01 22:00:00');
call NewComment(4,1,'A good start but more in-depth information can easily be found elsewhere.','2014-01-01 22:00:00');
call NewComment(4,2,'A good start but more in-depth information can easily be found elsewhere.','2014-01-15 22:00:00');
call NewComment(4,3,'A good start but more in-depth information can easily be found elsewhere.','2014-02-01 22:00:00');
call NewComment(4,4,'A good start but more in-depth information can easily be found elsewhere.','2014-02-15 22:00:00');
call NewComment(4,5,'A good start but more in-depth information can easily be found elsewhere.','2014-03-01 22:00:00');
call NewComment(5,1,'Why was this even written?  An utter waste of my precious time...','2014-01-01 22:00:00');
call NewComment(5,2,'Why was this even written?  An utter waste of my precious time...','2014-01-15 22:00:00');
call NewComment(5,3,'Why was this even written?  An utter waste of my precious time...','2014-02-01 22:00:00');
call NewComment(5,4,'Why was this even written?  An utter waste of my precious time...','2014-02-15 22:00:00');
call NewComment(5,5,'Why was this even written?  An utter waste of my precious time...','2014-03-01 22:00:00');
**************END CONTENT OF dba1finalcommenter.sql**********************/

alter table ArticleCategories drop ArticleID;
alter table ArticleCategories add CategoryID int auto_increment first primary key(CategoryID));
drop table if exists ArticleCategories;
source dba1finalcategories.sql;

/**************BEGIN CONTENT OF dba1finalcategories.sql********************
create table ArticleCategories(CategoryID int(11) auto_increment, Category varchar(100) not null, primary key(CategoryID)) engine=INNODB;
insert into ArticleCategories (Category) values ('Non-Fiction');
insert into ArticleCategories (Category) values ('Inspirational');
insert into ArticleCategories (Category) values ('Poetry');
**************END CONTENT OF dba1finalcategories.sql**********************/

alter table Articles drop Category;
alter table Articles add CategoryID int(11) after DateWritten;
update Articles set CategoryID=1 where ArticleID=1;
update Articles set CategoryID=1 where ArticleID=2;
update Articles set CategoryID=1 where ArticleID=3;
update Articles set CategoryID=2 where ArticleID=4;
update Articles set CategoryID=3 where ArticleID=5;

source dba1finalviews;

/**************BEGIN CONTENT OF dba1finalviews.sql********************
delimiter //
create procedure NewArticleView (AID int(11), Date datetime) begin insert into ArticleViews (ArticleID, DateViewed) values (AID, Date); END; //
delimiter ;
call NewArticleView (1, '2014-03-10 17:00:00');
call NewArticleView (1, '2014-03-10 19:00:00');
call NewArticleView (1, '2014-03-10 21:00:00');
call NewArticleView (1, '2014-03-24 03:00:00');
call NewArticleView (1, '2014-03-24 05:00:00');
call NewArticleView (1, '2014-03-24 07:00:00');
call NewArticleView (1, '2014-03-24 09:00:00');
call NewArticleView (1, '2014-03-24 11:00:00');
call NewArticleView (1, '2014-03-24 13:00:00');
call NewArticleView (1, '2014-03-24 15:00:00');
call NewArticleView (1, '2014-03-24 17:00:00');
call NewArticleView (1, '2014-03-24 19:00:00');
call NewArticleView (1, '2014-03-24 21:00:00');
call NewArticleView (1, '2014-03-24 23:00:00');
call NewArticleView (1, '2014-04-04 13:00:00');
call NewArticleView (1, '2014-04-04 15:00:00');
call NewArticleView (1, '2014-04-04 17:00:00');
call NewArticleView (1, '2014-04-04 19:00:00');
call NewArticleView (2, '2014-03-09 17:00:00');
call NewArticleView (2, '2014-03-09 19:00:00');
call NewArticleView (2, '2014-03-24 03:00:00');
call NewArticleView (2, '2014-03-24 05:00:00');
call NewArticleView (2, '2014-03-24 07:00:00');
call NewArticleView (2, '2014-03-24 09:00:00');
call NewArticleView (2, '2014-03-24 11:00:00');
call NewArticleView (2, '2014-03-24 13:00:00');
call NewArticleView (2, '2014-04-04 21:00:00');
call NewArticleView (2, '2014-04-04 23:00:00');
call NewArticleView (3, '2014-03-09 11:00:00');
call NewArticleView (3, '2014-03-09 13:00:00');
call NewArticleView (3, '2014-03-09 15:00:00');
call NewArticleView (3, '2014-03-09 17:00:00');
call NewArticleView (3, '2014-03-09 19:00:00');
call NewArticleView (3, '2014-03-09 21:00:00');
call NewArticleView (3, '2014-03-24 15:00:00');
call NewArticleView (3, '2014-03-24 17:00:00');
call NewArticleView (3, '2014-03-24 19:00:00');
call NewArticleView (3, '2014-04-04 21:00:00');
call NewArticleView (4, '2014-03-09 21:00:00');
call NewArticleView (4, '2014-03-24 01:00:00');
call NewArticleView (4, '2014-03-24 03:00:00');
call NewArticleView (4, '2014-03-24 05:00:00');
call NewArticleView (4, '2014-03-24 07:00:00');
call NewArticleView (4, '2014-03-24 09:00:00');
call NewArticleView (4, '2014-03-24 11:00:00');
call NewArticleView (4, '2014-03-24 13:00:00');
call NewArticleView (4, '2014-03-24 15:00:00');
call NewArticleView (4, '2014-03-24 17:00:00');
call NewArticleView (4, '2014-04-04 21:00:00');
call NewArticleView (5, '2014-03-09 19:00:00');
call NewArticleView (5, '2014-03-09 21:00:00');
call NewArticleView (5, '2014-03-09 23:00:00');
call NewArticleView (5, '2014-03-24 21:00:00');
call NewArticleView (5, '2014-03-24 23:00:00');
call NewArticleView (5, '2014-04-04 13:00:00');
call NewArticleView (5, '2014-04-04 15:00:00');
call NewArticleView (5, '2014-04-04 17:00:00');
call NewArticleView (5, '2014-04-04 19:00:00');
call NewArticleView (5, '2014-04-04 21:00:00');
**************END CONTENT OF dba1finalviews.sql**********************/

source dba1finaladdcomment.sql;

/**************BEGIN CONTENT OF dba1finaladdcomments.sql********************
delimiter //
CREATE PROCEDURE AddComment (AID int(11), Cmmts text, Date datetime, First varchar(50), Last varchar(50), Email varchar(100))
BEGIN DECLARE email_count int(11); DECLARE commenter_id int(11);
SELECT COUNT(EmailAddress) into email_count FROM Commenters WHERE EmailAddress = Email;
IF email_count = 0 THEN INSERT INTO Commenters (CommenterID, FirstName, LastName, EmailAddress) VALUES(commenter_id, First, Last, Email); 
SELECT LAST_INSERT_ID() into commenter_id; 
ELSEIF email_count = 1 THEN SELECT CommenterID INTO commenter_id FROM Commenters WHERE EmailAddress = Email; 
END IF; 
INSERT INTO Comments(CommenterID, ArticleID, Comments, DateCommented) VALUES(commenter_id, AID, Cmmts, Date);
END;//
delimiter ;
**************END CONTENT OF dba1finaladdcomments.sql**********************/

call AddComment(1,'Best Ever!','2014-04-05 12:00:00','Tyla','Knowles','tyla@knowles.com');
call AddComment(1,'So informative, loved it!','2014-04-01 07:00:00','Rocky','Road','rockyroad@icecream.com');

source dba1finalarticledisplay.sql;

/**************BEGIN CONTENT OF dba1finalarticledisplay.sql********************
create view ArticleDisplay as select Au.FirstName as FirstName, Au.LastName as LastName, Au.EmailAddress as Email, Ar.Title as Title, Ar.ArticleText as Text, Ar.DateWritten as Date, Ca.Category as Category from ArticleAuthors as Au left join Articles as Ar on (Au.AuthorID=Ar.AuthorID) left join ArticleCategories as Ca on (Ar.CategoryID=Ca.CategoryID);
**************END CONTENT OF dba1finalarticledisplay.sql**********************/

select FirstName, LastName, Email, SUBSTRING(Title,1,20) as Title, SUBSTRING(Text,1,25) as Text, Date, Category from ArticleDisplay;

select SUBSTRING(Ar.Title,1,20) as Title, SUBSTRING(Ar.Blurb,1,20) as Blurb, Au.FirstName as FirstName, Au.LastName as LastName, match(Blurb) against('social forces') as Relevance from Articles as Ar left join ArticleAuthors as Au on (Ar.AuthorID=Au.AuthorID) where match(Blurb) against('social forces');

select SUBSTRING(Ar.Title,1,20) as Title, SUBSTRING(Ar.Blurb,1,20) as Blurb, Au.FirstName as FirstName, Au.LastName as LastName, match(Blurb) against('psychology') as Relevance from Articles as Ar left join ArticleAuthors as Au on (Ar.AuthorID=Au.AuthorID) where match(Blurb) against('psychology');

source dba1finalpivotarticleviews.sql;

/**************BEGIN CONTENT OF dba1finalpivotarticleviews.sql********************
SELECT Ar.Title as Article, 
SUM(CASE WHEN DATEDIFF(NOW(),AV.DateViewed)>=0 AND DATEDIFF(NOW(),AV.DateViewed)<=10 THEN 1 ELSE 0 END) AS 'D10', 
SUM(CASE WHEN DATEDIFF(NOW(),AV.DateViewed)>=11 AND DATEDIFF(NOW(),AV.DateViewed)<=20 THEN 1 ELSE 0 END) AS 'D20', 
SUM(CASE WHEN DATEDIFF(NOW(),AV.DateViewed)>=21 AND DATEDIFF(NOW(),AV.DateViewed)<=30 THEN 1 ELSE 0 END) AS 'D30' 
FROM Articles as Ar JOIN ArticleViews as AV on (Ar.ArticleID=AV.ArticleID) 
GROUP BY Ar.Title;
**************END CONTENT OF dba1finalpivotarticleviews.sql**********************/

source dba1finalmaxarticleviews.sql;

/**************BEGIN CONTENT OF dba1finalmaxarticleviews.sql********************
create view TotalViews as select Ar.Title as Article, count(AV.DateViewed) as TotalViews from Articles as Ar left join ArticleViews as AV on (Ar.ArticleID=AV.ArticleID) group by Ar.Title; 
**************END CONTENT OF dba1finalmaxarticleviews.sql**********************/

select Article, max(TotalViews) as MaxViews from TotalViews;
