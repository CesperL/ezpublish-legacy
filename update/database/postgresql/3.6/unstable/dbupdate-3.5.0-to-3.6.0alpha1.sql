UPDATE ezsite_data SET value='3.6.0alpha1' WHERE name='ezpublish-version';
UPDATE ezsite_data SET value='1' WHERE name='ezpublish-release';

CREATE TABLE eztipafriend_request (
        email_receiver varchar(100) not null,
        created int not null
);
create index email_receiver on eztipafriend_request(email_receiver);
create index created on eztipafriend_request(created);
