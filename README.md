Changes made:

1. device table - switched account_id (FK) to person_id(FK)
2. most tables - changing user_id(FK) to person_id(FK)
3. login_event & logout_event table - change datatype of date to datetime
4. purchase table - took out foreign key of purchase_product_id
5. urchase_product table - added purchase_id
6. social_comment table - change datatype of data to dateTime
7. socia_post table - change datatype of data to dateTime, added title attrtibute, changed datatype of content to LONGTEXT
8. social_like table - changed foreign key name from fk_account_id to sl_account_id due to conflict with foreign engineer having similar fk names
9. social_post table - changed foreign key name from fk_account_id to sp_account_id due to conflict with foreign engineer having similar fk names
10. deleted socials table because social_account table exists
