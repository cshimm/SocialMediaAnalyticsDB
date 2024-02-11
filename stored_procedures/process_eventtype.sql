
DELIMITER // 
CREATE PROCEDURE parse_event_type()
BEGIN
    -- Declare variables that will hold certain values from the datafeed
    DECLARE event_type INT; -- Will need to parse evcatcodes for this
    DECLARE account_id INT;
    DECLARE event_id_hold INT;
    DECLARE event_time INT;
    DECLARE event_type INT;
    DECLARE event_nature INT;
    DECLARE evcatcode_hold VARCHAR(45);
    DECLARE data_feed_max INT;

    DECLARE index_val INT;
    SET index_val = 1;

    DECLARE evcat1 INT;
    DECLARE evcat2 INT;
    

    -- this will store the largest data_feed_id so we can go through each row in the table
    SELECT MAX(data_feed_id) INTO data_feed_max
    FROM SM_data_feed;

    
    -- this code will run until it has parsed through the data feed
    WHILE (index_val < (data_feed_max+1)) {
        -- set the values of variables
        SELECT smuid, event_id, evcatcodes, timeonevent
        INTO account_id, event_id_hold, evcatcode_hold, timeonevent
        FROM SM_data_feed where data_feed_id =index_val;

    -- just assume the delimiter is a comma for simplicity
    -- if we were to check delimiters we can have casses to change a delimiter variable
    -- based on the delimiter that is read from the string

    -- The following code will take the value from the string and convert it into an unsigned integer
    -- we will assume that the string only has one value on either side of the delimiter
    -- the CAST will ignore all the spaces in the string if there are spaces
    SET evcat1 = CAST(substring_index(evcatcode_hold, ',', -1) AS UNSIGNED);
    SET evcat2 = CAST(substring_index(evcatcode_hold, ',', 1) AS UNSIGNED);

    -- the following will check if value is within range (0-8) & (0-7)
    IF evcat1 > 8
        SET evcat1 = 0;
    END IF;
    IF evcat2 > 7
        SET evcat2 = 0;
    END IF;

    CASE 
        -- first case if unknown event or event in social_event
        WHEN evcat1 = 0 || evcat1 = 4
        THEN CALL UpsertSocialEvent(event_id, evcat1, evcat2, timeonevent);
        
        -- second case for device_event_log
        WHEN evcat1 > 0 && evcat1 < 4
        THEN CALL UpsertDeviceLog(event_id, evcat1, timeonevent);

        -- third case for social_like
        WHEN evcat1 = 5
        THEN

        -- fourth case for social_repost
        WHEN evcat1 = 6
        THEN

        -- fifth case for social_mention
        WHEN evcat1 = 7
        THEN
        
        -- sixth case for soaicl_comment
        WHEN evcat1 = 8
        THEN


    END --end CASE





    }
    

END //
DELIMITER ;


-- Code to update or insert table
DELIMITER //
CREATE PROCEDURE UpsertSocialEvent(IN event_id INT, IN evcat1 INT, IN evcat2 INT, IN dateTime1 DATETIME)
BEGIN
    DECLARE entry_exist INT;

    --check if the entry exists
    SELECT COUNT(*)
    INTO entry_exist
    FROM social_event
    WHERE social_event_id = event_id;

    -- if event_id exists, then just update otherwise create an entry
    IF entry_exist > 0 THEN
            UPDATE social_event
            SET event_type_id = evcat1, event_nature_id = evcat2, event_time = dateTime1
            WHERE social_event_id = event_id;
        ELSE
            INSERT INTO social_event (social_event_id, event_type_id, event_nature_id, event_time)
            VALUES (event_id, evcat1, evcat2, dateTime1);
    END IF;
END //
DELIMITER ;

-- Code to update or insert table
DELIMITER //
CREATE PROCEDURE UpsertDeviceLog(IN event_id INT, IN evcat1 INT, IN dateTime1 DATETIME)
BEGIN
    DECLARE entry_exist INT;

    --check if the entry exists
    SELECT COUNT(*)
    INTO entry_exist
    FROM device_event_log
    WHERE device_event_id = event_id;

    -- if event_id exists, then just update otherwise create an entry
    IF entry_exist > 0 THEN
            UPDATE device_event_log
            SET device_event_id = evcat1, event_time = dateTime1
            WHERE device_event_id = event_id;
        ELSE
            INSERT INTO device_event_log (social_event_id, event_type_id, event_time)
            VALUES (event_id, evcat1, dateTime1);
    END IF;
END //
DELIMITER ;