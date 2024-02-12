
-- this code will handle events type, timeonevent, mentions
DELIMITER // 
CREATE PROCEDURE parse_event()
BEGIN
    -- Declare variables that will hold certain values from the datafeed
    DECLARE event_type INT; -- Will need to parse evcatcodes for this
    DECLARE account_id INT;
    DECLARE event_id_hold INT;
    DECLARE event_nature INT;
    DECLARE event_time VARCHAR(45);
    DECLARE event_time_DT DATETIME;
    DECLARE evcatcode_hold VARCHAR(45);
    DECLARE mentions_hold VARCHAR(400);
    DECLARE content_hold VARCHAR(400);
    DECLARE data_feed_max INT;

    DECLARE index_val INT;
    SET index_val = 1;

    DECLARE evcat1 INT;
    DECLARE evcat2 INT;
    

    -- this will store the largest data_feed_id so we can go through each row in the table
    SELECT MAX(data_feed_id) INTO data_feed_max
    FROM SM_data_feed;

    
    -- this code will run until it has parsed through the data feed
    WHILE index_val < (data_feed_max+1) DO
        -- set the values of variables
        SELECT smuid, event_id, evcatcodes, timeonevent, hashtags, content
        INTO account_id, event_id_hold, evcatcode_hold, event_time, mentions_hold, content_hold
        FROM SM_data_feed where data_feed_id = index_val;

    -- just assume the delimiter is a comma for simplicity
    -- if we were to check delimiters we can have casses to change a delimiter variable
    -- based on the delimiter that is read from the string

    -- The following code will take the value from the string and convert it into an unsigned integer
    -- we will assume that the string only has one value on either side of the delimiter
    -- the CAST will ignore all the spaces in the string if there are spaces
    SET evcat1 = CAST(SUBSTRING_INDEX(evcatcode_hold, ',', 1) AS UNSIGNED);
    SET evcat2 = CAST(SUBSTRING_INDEX(evcatcode_hold, ',', -1) AS UNSIGNED);

    -- the following will check if value is within range (0-8) & (0-7)
    IF evcat1 > 8 THEN 
        SET evcat1 = 0;
    END IF; THEN
    IF evcat2 > 7
        SET evcat2 = 0;
    END IF;

    -- format the timeonevent with default or proper format
    IF event_time IS NULL THEN
            SET event_time_DT = '0000-00-00 00:00:00';
        ELSE
            SET event_time_DT = STR_TO_DATE(event_time, '%Y-%m-%d %H:%i:%s');
    END IF;


    CASE 
        -- first case if unknown event or event in social_event
        WHEN evcat1 = 0 || evcat1 = 4 THEN 
            CALL UpsertSocialEvent(event_id, evcat1, evcat2, event_time_DT, content_hold);
        
        -- second case for device_event_log
        WHEN evcat1 > 0 && evcat1 < 4 THEN 
            CALL UpsertDeviceLog(event_id, evcat1, event_time_DT);

        -- third case for social_action: comment, like, repost, mention
        ELSE
            CALL UpsertActions(event_id, evcat1, event_time_DT, content_hold);

    END --end CASE

    SET index_val = index_val + 1; -- incrament so that it will parse through all the feed
    END WHILE;
    

END //
DELIMITER ;


-- Code to update or insert data int social_event table
DELIMITER //
CREATE PROCEDURE UpsertSocialEvent(IN event_id INT, IN evcat1 INT, IN evcat2 INT, IN dateTime1 DATETIME, IN content1 VARCHAR(400))
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
            SET event_type_id = evcat1, event_nature_id = evcat2, event_time = dateTime1, content = content1
            WHERE social_event_id = event_id;
        ELSE
            INSERT INTO social_event (social_event_id, event_type_id, event_nature_id, event_time, content)
            VALUES (event_id, evcat1, evcat2, dateTime1, content1);
    END IF;
END //
DELIMITER ;

-- Code to update or insert data into device_event_log table
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
            SET event_type_id = evcat1, event_time = dateTime1
            WHERE device_event_id = event_id;
        ELSE
            INSERT INTO device_event_log (device_event_id, event_type_id, event_time)
            VALUES (event_id, evcat1, dateTime1);
    END IF;
END //
DELIMITER ;


-- Code to update or insert data into social_action table
DELIMITER //
CREATE PROCEDURE UpsertActions(IN event_id INT, IN evcat1 INT, IN dateTime1 DATETIME, IN content1 VARCHAR(400))
BEGIN
    DECLARE entry_exist INT;

    --check if the entry exists
    SELECT COUNT(*)
    INTO entry_exist
    FROM social_action
    WHERE social_action_id = event_id;

    -- if event_id exists, then just update otherwise create an entry
    IF entry_exist > 0 THEN
            UPDATE social_action
            SET event_type_id = evcat1, event_time = dateTime1, content = content1
            WHERE social_action_id = event_id;
        ELSE
            INSERT INTO social_action (social_action_id, event_type_id, event_time, content)
            VALUES (event_id, evcat1, dateTime1, content1);
    END IF;
END //
DELIMITER ;
