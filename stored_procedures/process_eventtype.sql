
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
    SET @index_val := 1;

    --this will store the largest data_feed_id so we can go through each row in the table
    SELECT MAX(data_feed_id) INTO data_feed_max
    FROM SM_data_feed;

    
    -- this code will run until it has parsed through the data feed
    WHILE (index_val < (data_feed_max+1)) {
        -- set the values of variables
        SELECT smuid, event_id, evcatcodes, timeonevent
        INTO account_id, event_id_hold, evcatcode_hold, timeonevent
        FROM SM_data_feed where data_feed_id =index_val;




    }
    


END //
DELIMITER ;